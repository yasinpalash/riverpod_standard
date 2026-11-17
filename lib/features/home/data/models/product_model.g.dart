// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] == null ? 0 : _toInt(json['id']),
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      thumbnail: json['thumbnail'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      category: json['category'] as String? ?? '',
      rating: json['rating'] == null ? 0 : _toDouble(json['rating']),
      discountPercentage:
          json['discountPercentage'] == null
              ? 0
              : _toDouble(json['discountPercentage']),
      stock: json['stock'] == null ? 0 : _toInt(json['stock']),
      price: json['price'] == null ? 0 : _toInt(json['price']),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'brand': instance.brand,
      'category': instance.category,
      'rating': instance.rating,
      'discountPercentage': instance.discountPercentage,
      'stock': instance.stock,
      'price': instance.price,
      'images': instance.images,
    };

_ProductPageModel _$ProductPageModelFromJson(Map<String, dynamic> json) =>
    _ProductPageModel(
      products:
          (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      total: json['total'] == null ? 0 : _toInt(json['total']),
      skip: json['skip'] == null ? 0 : _toInt(json['skip']),
    );

Map<String, dynamic> _$ProductPageModelToJson(_ProductPageModel instance) =>
    <String, dynamic>{
      'products': instance.products,
      'total': instance.total,
      'skip': instance.skip,
    };
