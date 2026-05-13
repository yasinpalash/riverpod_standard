import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/domain/models/paginated_response.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';

abstract class DashboardRepository {
  Future<Either<AppException, PaginatedResponse>> fetchProducts({
    required int skip,
  });
  Future<Either<AppException, PaginatedResponse>> searchProducts({
    required int skip,
    required String query,
  });
}
