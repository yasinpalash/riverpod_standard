import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_standard/features/home/domain/entities/product.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_page.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

int _toInt(Object? v) => (v as num?)?.toInt() ?? 0;
double _toDouble(Object? v) => (v as num?)?.toDouble() ?? 0;

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    @Default(0) @JsonKey(fromJson: _toInt) int id,
    @Default('') String title,
    @Default('') String description,
    @Default('') String thumbnail,
    @Default('') String brand,
    @Default('') String category,
    @Default(0) @JsonKey(fromJson: _toDouble) double rating,
    @Default(0) @JsonKey(fromJson: _toDouble) double discountPercentage,
    @Default(0) @JsonKey(fromJson: _toInt) int stock,
    @Default(0) @JsonKey(fromJson: _toInt) int price,
    @Default([]) List<String> images,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Product toEntity() => Product(
    id: id,
    title: title,
    description: description,
    thumbnail: thumbnail,
    brand: brand,
    category: category,
    rating: rating,
    discountPercentage: discountPercentage,
    stock: stock,
    price: price,
    images: images,
  );
}

@freezed
abstract class ProductPageModel with _$ProductPageModel {
  const ProductPageModel._();

  const factory ProductPageModel({
    @Default([]) List<ProductModel> products,
    @Default(0) @JsonKey(fromJson: _toInt) int total,
    @Default(0) @JsonKey(fromJson: _toInt) int skip,
  }) = _ProductPageModel;

  factory ProductPageModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPageModelFromJson(json);

  ProductPage toEntity() => ProductPage(
    products: products.map((p) => p.toEntity()).toList(),
    total: total,
    skip: skip,
  );
}
