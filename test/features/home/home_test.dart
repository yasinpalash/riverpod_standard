import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/errors/failure_code.dart';
import 'package:riverpod_standard/core/errors/failures.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/features/home/data/datasources/home_remote_data_source.dart';
import 'package:riverpod_standard/features/home/data/models/product_model.dart';
import 'package:riverpod_standard/features/home/data/repositories/home_repository_impl.dart';
import 'package:riverpod_standard/features/home/di/home_di.dart';
import 'package:riverpod_standard/features/home/domain/entities/product.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_listing.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_page.dart';
import 'package:riverpod_standard/features/home/domain/repositories/home_repository.dart';
import 'package:riverpod_standard/features/home/domain/usecases/product_usecases.dart';
import 'package:riverpod_standard/features/home/presentation/providers/home_state_provider.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';

class _MockDatasource extends Mock implements HomeDatasource {}

class _MockRepository extends Mock implements HomeRepository {}

void main() {
  const product = Product(id: 1, title: 'Phone', price: 10);
  const page = ProductPage(products: [product], total: 1, skip: 0);

  group('ProductPageModel', () {
    test('parses JSON and maps to the entity', () {
      final model = ProductPageModel.fromJson({
        'products': [
          {'id': 1, 'title': 'Phone', 'price': 10.5, 'rating': 4},
        ],
        'total': 1,
        'skip': 0,
      });
      expect(model.toEntity().products.single.price, 10);
      expect(model.toEntity().products.single.rating, 4.0);
      expect(model.total, 1);
    });
  });

  group('HomeRepositoryImpl', () {
    late _MockDatasource datasource;
    late HomeRepositoryImpl repository;

    setUp(() {
      datasource = _MockDatasource();
      repository = HomeRepositoryImpl(datasource);
    });

    test('returns the mapped entity on success', () async {
      when(
        () => datasource.fetchPaginatedProducts(skip: 0, limit: 20),
      ).thenAnswer((_) async => ProductPageModel.fromJson({'total': 0}));

      final result = await repository.fetchProducts(skip: 0, limit: 20);

      expect(result.isRight(), isTrue);
    });

    test('maps data-source exceptions to Failure', () async {
      when(() => datasource.fetchPaginatedProducts(skip: 0, limit: 20)).thenThrow(
        AppException(message: 'down', statusCode: 503, identifier: 'srv'),
      );

      final result = await repository.fetchProducts(skip: 0, limit: 20);

      expect(
        result.fold((f) => f, (_) => null),
        const Failure(
          code: FailureCode.server,
          statusCode: 503,
          serverMessage: 'down',
          identifier: 'srv',
        ),
      );
    });
  });

  group('ProductListing', () {
    test('has more until the total is reached', () {
      expect(const ProductListing().hasMore, isTrue);
      expect(const ProductListing(products: [product], total: 2).hasMore, isTrue);
      expect(const ProductListing(products: [product], total: 1).hasMore, isFalse);
    });

    test('next skip is the number of loaded items', () {
      expect(const ProductListing(products: [product], total: 5).nextSkip, 1);
    });

    test('append accumulates pages', () {
      final listing = const ProductListing().append(page);
      expect(listing.products, [product]);
      expect(listing.total, 1);
    });
  });

  group('FetchProducts use case', () {
    test('requests the next page and appends it', () async {
      final repository = _MockRepository();
      when(
        () => repository.fetchProducts(skip: 0, limit: ProductListing.pageSize),
      ).thenAnswer((_) async => const Right(page));

      final result = await FetchProducts(repository)(const ProductListing());

      expect(result.fold((_) => null, (l) => l.products), [product]);
    });

    test('does not call the repository when everything is loaded', () async {
      final repository = _MockRepository();
      const done = ProductListing(products: [product], total: 1);

      final result = await FetchProducts(repository)(done);

      expect(result.fold((_) => null, (l) => l), done);
      verifyZeroInteractions(repository);
    });
  });

  group('HomeNotifier', () {
    test('loads products on start', () async {
      final repository = _MockRepository();
      when(
        () => repository.fetchProducts(skip: any(named: 'skip'), limit: any(named: 'limit')),
      ).thenAnswer((_) async => const Right(page));
      final container = ProviderContainer(
        overrides: [homeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      container.listen(homeNotifierProvider, (_, _) {});

      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final state = container.read(homeNotifierProvider);
      expect(state.productList, [product]);
      expect(state.state, HomeConcreteState.fetchedAllProducts);
    });

    test('exposes the failure message when loading fails', () async {
      final repository = _MockRepository();
      when(() => repository.fetchProducts(skip: any(named: 'skip'), limit: any(named: 'limit'))).thenAnswer(
        (_) async => const Left(
          Failure(
            code: FailureCode.server,
            statusCode: 500,
            serverMessage: 'nope',
          ),
        ),
      );
      final container = ProviderContainer(
        overrides: [homeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      container.listen(homeNotifierProvider, (_, _) {});

      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      final state = container.read(homeNotifierProvider);
      expect(state.state, HomeConcreteState.failure);
      expect(state.failure?.serverMessage, 'nope');
    });

    test('drops a stale response after resetState', () async {
      final repository = _MockRepository();
      final slow = Completer<Either<Failure, ProductPage>>();
      var calls = 0;
      when(
        () => repository.fetchProducts(
          skip: any(named: 'skip'),
          limit: any(named: 'limit'),
        ),
      ).thenAnswer((_) {
        calls++;
        return calls == 1
            ? slow.future
            : Future.value(const Right(ProductPage(products: [], total: 0, skip: 0)));
      });
      final container = ProviderContainer(
        overrides: [homeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      container.listen(homeNotifierProvider, (_, _) {});
      await Future<void>.delayed(Duration.zero);

      final notifier = container.read(homeNotifierProvider.notifier)
        ..resetState();
      await notifier.fetchProducts();
      slow.complete(const Right(page));
      await Future<void>.delayed(Duration.zero);

      expect(container.read(homeNotifierProvider).productList, isEmpty);
    });
  });
}
