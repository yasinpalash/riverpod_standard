import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/features/home/domain/models/product/product_model.dart';
import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/paginated_response.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import '../../../../core/network/api_service.dart';

abstract class HomeDatasource {
  Future<Either<AppException, PaginatedResponse<Product>>>
  fetchPaginatedProducts({required int skip});
  Future<Either<AppException, PaginatedResponse<Product>>>
  searchPaginatedProducts({required int skip, required String query});
}

class HomeRemoteDatasource extends HomeDatasource {
  final ApiService networkService;
  HomeRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse<Product>>>
  fetchPaginatedProducts({required int skip}) async {
    return networkService.get<PaginatedResponse<Product>>(
      ApiConstants.products,
      queryParameters: {
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: ApiConstants.productsPerPage,
      },
      parser: _parseProductsPage,
    );
  }

  @override
  Future<Either<AppException, PaginatedResponse<Product>>>
  searchPaginatedProducts({required int skip, required String query}) async {
    return networkService.get<PaginatedResponse<Product>>(
      ApiConstants.searchProducts,
      queryParameters: {
        ApiConstants.searchQuery: query,
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: ApiConstants.productsPerPage,
      },
      parser: _parseProductsPage,
    );
  }

  PaginatedResponse<Product> _parseProductsPage(dynamic json) {
    final jsonData = coerceJsonMap(json);
    final products =
        (jsonData['products'] as List<dynamic>? ?? [])
            .map((item) => Product.fromJson(coerceJsonMap(item)))
            .toList();

    return PaginatedResponse<Product>.fromJson(jsonData, products);
  }
}
