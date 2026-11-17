import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/features/home/data/datasources/home_remote_data_source.dart';
import 'package:riverpod_standard/features/home/data/repositories/home_repository_impl.dart';
import 'package:riverpod_standard/features/home/domain/repositories/home_repository.dart';
import 'package:riverpod_standard/features/home/domain/usecases/product_usecases.dart';
import 'package:riverpod_standard/shared/providers/app_provider.dart';

// Composition root for the home feature.
final homeDatasourceProvider = Provider<HomeDatasource>(
  (ref) => HomeRemoteDatasource(ref.watch(networkServiceProvider)),
);

final homeRepositoryProvider = Provider<HomeRepository>(
  (ref) => HomeRepositoryImpl(ref.watch(homeDatasourceProvider)),
);

final fetchProductsProvider = Provider(
  (ref) => FetchProducts(ref.watch(homeRepositoryProvider)),
);
final searchProductsProvider = Provider(
  (ref) => SearchProducts(ref.watch(homeRepositoryProvider)),
);
