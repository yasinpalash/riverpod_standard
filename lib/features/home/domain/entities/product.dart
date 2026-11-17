import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.thumbnail = '',
    this.brand = '',
    this.category = '',
    this.rating = 0,
    this.discountPercentage = 0,
    this.stock = 0,
    this.price = 0,
    this.images = const [],
  });

  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final String brand;
  final String category;
  final double rating;
  final double discountPercentage;
  final int stock;
  final int price;
  final List<String> images;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    thumbnail,
    brand,
    category,
    rating,
    discountPercentage,
    stock,
    price,
    images,
  ];
}
