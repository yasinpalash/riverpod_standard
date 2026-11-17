import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/core/network/api_response_parser.dart';
import 'package:riverpod_standard/core/network/api_service.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/features/home/data/models/product_model.dart';

abstract class HomeDatasource {
  /// Both methods throw an [AppException] on failure.
  Future<ProductPageModel> fetchPaginatedProducts({
    required int skip,
    required int limit,
  });
  Future<ProductPageModel> searchPaginatedProducts({
    required int skip,
    required int limit,
    required String query,
  });
}

class HomeRemoteDatasource extends HomeDatasource {
  HomeRemoteDatasource(this.networkService);
  final ApiService networkService;

  @override
  Future<ProductPageModel> fetchPaginatedProducts({
    required int skip,
    required int limit,
  }) async {
    final result = await networkService.get<ProductPageModel>(
      ApiConstants.products,
      queryParameters: {
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: limit,
      },
      parser: _parse,
    );
    return result.getOrThrow();
  }

  @override
  Future<ProductPageModel> searchPaginatedProducts({
    required int skip,
    required int limit,
    required String query,
  }) async {
    final result = await networkService.get<ProductPageModel>(
      ApiConstants.searchProducts,
      queryParameters: {
        ApiConstants.searchQuery: query,
        ApiConstants.skipQuery: skip,
        ApiConstants.limitQuery: limit,
      },
      parser: _parse,
    );
    return result.getOrThrow();
  }

  ProductPageModel _parse(dynamic json) =>
      ProductPageModel.fromJson(coerceJsonMap(json));
}
