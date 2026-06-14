import 'package:riverpod_standard/features/home/domain/repositories/home_repository.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/domain/models/paginated_response.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import '../datasource/home_remote_datasource.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDatasource homeDatasource;
  HomeRepositoryImpl(this.homeDatasource);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchProducts({
    required int skip,
  }) {
    return homeDatasource.fetchPaginatedProducts(skip: skip);
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchProducts({
    required int skip,
    required String query,
  }) {
    return homeDatasource.searchPaginatedProducts(skip: skip, query: query);
  }
}
