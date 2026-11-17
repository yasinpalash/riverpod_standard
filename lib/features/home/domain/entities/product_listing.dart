import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/features/home/domain/entities/product.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_page.dart';

/// Accumulated, paginated product list and its pagination rules.
class ProductListing extends Equatable {
  const ProductListing({this.products = const [], this.total});

  /// Number of items requested per page.
  static const pageSize = 20;

  final List<Product> products;

  /// Total items available on the server; `null` until the first page loads.
  final int? total;

  bool get isEmpty => products.isEmpty;
  bool get hasLoadedOnce => total != null;
  bool get hasMore => total == null || products.length < total!;
  int get nextSkip => products.length;

  ProductListing append(ProductPage page) =>
      ProductListing(products: [...products, ...page.products], total: page.total);

  @override
  List<Object?> get props => [products, total];
}
