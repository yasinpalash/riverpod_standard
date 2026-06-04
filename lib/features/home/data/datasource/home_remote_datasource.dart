import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/domain/models/paginated_response.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';
import '../../../../shared/data/remote/network_service.dart';

abstract class HomeDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts({
    required int skip,
  });
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts({
    required int skip,
    required String query,
  });
}

class HomeRemoteDatasource extends HomeDatasource {
  final NetworkService networkService;
  HomeRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts({
    required int skip,
  }) async {
    final response = await networkService.get(
      ApiConstants.products,
      queryParameters: {
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: ApiConstants.productsPerPage,
      },
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'fetchPaginatedData',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = PaginatedResponse.fromJson(
        jsonData,
        jsonData['products'] ?? [],
      );
      return Right(paginatedResponse);
    });
  }

  @override
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts({
    required int skip,
    required String query,
  }) async {
    final response = await networkService.get(
      ApiConstants.searchProducts,
      queryParameters: {
        ApiConstants.searchQuery: query,
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: ApiConstants.productsPerPage,
      },
    );

    return response.fold((l) => Left(l), (r) {
      final jsonData = r.data;
      if (jsonData == null) {
        return Left(
          AppException(
            identifier: 'search PaginatedData',
            statusCode: 0,
            message: 'The data is not in the valid format.',
          ),
        );
      }
      final paginatedResponse = PaginatedResponse.fromJson(
        jsonData,
        jsonData['products'] ?? [],
      );
      return Right(paginatedResponse);
    });
  }
}
