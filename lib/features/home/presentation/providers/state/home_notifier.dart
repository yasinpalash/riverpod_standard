import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/home/di/home_di.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_listing.dart';
import 'package:riverpod_standard/features/home/domain/usecases/product_usecases.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  @override
  HomeState build() {
    Future.microtask(fetchProducts);
    return const HomeState.initial();
  }

  ProductListing get _listing =>
      state.hasData
          ? ProductListing(products: state.productList, total: state.total)
          : const ProductListing();

  bool get _isBusy =>
      state.state == HomeConcreteState.loading ||
      state.state == HomeConcreteState.fetchingMore;

  Future<void> fetchProducts() => _load(
    (listing) => ref.read(fetchProductsProvider)(listing),
  );

  Future<void> searchProducts(String query) => _load(
    (listing) => ref.read(searchProductsProvider)(
      SearchProductsParams(current: listing, query: query),
    ),
  );

  Future<void> _load(
    ResultFuture<ProductListing> Function(ProductListing listing) load,
  ) async {
    if (_isBusy) return;
    final listing = _listing;
    if (!listing.hasMore) {
      state = state.copyWith(
        state: HomeConcreteState.endReached,
        isLoading: false,
      );
      return;
    }

    state = state.copyWith(
      errorMessage: '',
      state:
          listing.isEmpty
              ? HomeConcreteState.loading
              : HomeConcreteState.fetchingMore,
      isLoading: true,
    );
    _apply(await load(listing));
  }

  void _apply(Result<ProductListing> result) {
    result.fold(
      (failure) {
        state = state.copyWith(
          state: HomeConcreteState.failure,
          errorMessage: failure.message,
          isLoading: false,
        );
      },
      (listing) {
        state = state.copyWith(
          productList: listing.products,
          state:
              listing.hasMore
                  ? HomeConcreteState.loaded
                  : HomeConcreteState.fetchedAllProducts,
          hasData: true,
          total: listing.total ?? 0,
          isLoading: false,
        );
      },
    );
  }

  void resetState() {
    state = const HomeState.initial();
  }
}
