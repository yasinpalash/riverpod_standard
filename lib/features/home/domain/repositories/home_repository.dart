import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/paginated_response.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import '../models/product/product_model.dart';

abstract class HomeRepository {
  Future<Either<AppException, PaginatedResponse<Product>>> fetchProducts({
    required int skip,
  });
  Future<Either<AppException, PaginatedResponse<Product>>> searchProducts({
    required int skip,
    required String query,
  });
}
