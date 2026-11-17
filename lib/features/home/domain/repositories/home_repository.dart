import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_page.dart';

abstract class HomeRepository {
  ResultFuture<ProductPage> fetchProducts({
    required int skip,
    required int limit,
  });
  ResultFuture<ProductPage> searchProducts({
    required int skip,
    required int limit,
    required String query,
  });
}
