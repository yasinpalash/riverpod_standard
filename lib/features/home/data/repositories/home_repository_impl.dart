import 'package:riverpod_standard/core/errors/exception_mapper.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/home/data/datasources/home_remote_data_source.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_page.dart';
import 'package:riverpod_standard/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this._datasource);
  final HomeDatasource _datasource;

  @override
  ResultFuture<ProductPage> fetchProducts({
    required int skip,
    required int limit,
  }) => ExceptionMapper.guard(() async {
    final page = await _datasource.fetchPaginatedProducts(
      skip: skip,
      limit: limit,
    );
    return page.toEntity();
  });

  @override
  ResultFuture<ProductPage> searchProducts({
    required int skip,
    required int limit,
    required String query,
  }) => ExceptionMapper.guard(() async {
    final page = await _datasource.searchPaginatedProducts(
      skip: skip,
      limit: limit,
      query: query,
    );
    return page.toEntity();
  });
}
