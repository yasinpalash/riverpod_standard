import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/features/home/domain/entities/product.dart';

class ProductPage extends Equatable {
  const ProductPage({
    required this.products,
    required this.total,
    required this.skip,
  });

  final List<Product> products;
  final int total;
  final int skip;

  @override
  List<Object?> get props => [products, total, skip];
}
