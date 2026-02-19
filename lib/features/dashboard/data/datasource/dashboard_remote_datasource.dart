import 'package:riverpod_standard/shared/domain/models/either.dart';
import 'package:riverpod_standard/shared/domain/models/paginated_response.dart';
import 'package:riverpod_standard/shared/exceptions/http_exception.dart';

import '../../../../shared/data/remote/network_service.dart';

abstract class DashboardDatasource {
  Future<Either<AppException, PaginatedResponse>> fetchPaginatedProducts({
    required int skip,
  });
  Future<Either<AppException, PaginatedResponse>> searchPaginatedProducts({
    required int skip,
    required String query,
  });
}

class DashboardRemoteDatasource extends DashboardDatasource {
  final NetworkService networkService;
  DashboardRemoteDatasource(this.networkService);

  @override
  Future<Either<AppException, PaginatedResponse>>
  fetchPaginatedProducts({required int skip})  async{
    // TODO: implement fetchPaginatedProduct
    throw UnimplementedError();
  }

  @override
  Future<Either<AppException, PaginatedResponse<dynamic>>>
  searchPaginatedProducts({required int skip, required String query}) {
    // TODO: implement searchPaginatedProducts
    throw UnimplementedError();
  }
}
