// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

@JsonKey(fromJson: _toInt) int get id; String get title; String get description; String get thumbnail; String get brand; String get category;@JsonKey(fromJson: _toDouble) double get rating;@JsonKey(fromJson: _toDouble) double get discountPercentage;@JsonKey(fromJson: _toInt) int get stock;@JsonKey(fromJson: _toInt) int get price; List<String> get images;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other.images, images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,thumbnail,brand,category,rating,discountPercentage,stock,price,const DeepCollectionEquality().hash(images));

@override
String toString() {
  return 'ProductModel(id: $id, title: $title, description: $description, thumbnail: $thumbnail, brand: $brand, category: $category, rating: $rating, discountPercentage: $discountPercentage, stock: $stock, price: $price, images: $images)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _toInt) int id, String title, String description, String thumbnail, String brand, String category,@JsonKey(fromJson: _toDouble) double rating,@JsonKey(fromJson: _toDouble) double discountPercentage,@JsonKey(fromJson: _toInt) int stock,@JsonKey(fromJson: _toInt) int price, List<String> images
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? thumbnail = null,Object? brand = null,Object? category = null,Object? rating = null,Object? discountPercentage = null,Object? stock = null,Object? price = null,Object? images = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _toInt)  int id,  String title,  String description,  String thumbnail,  String brand,  String category, @JsonKey(fromJson: _toDouble)  double rating, @JsonKey(fromJson: _toDouble)  double discountPercentage, @JsonKey(fromJson: _toInt)  int stock, @JsonKey(fromJson: _toInt)  int price,  List<String> images)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.brand,_that.category,_that.rating,_that.discountPercentage,_that.stock,_that.price,_that.images);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _toInt)  int id,  String title,  String description,  String thumbnail,  String brand,  String category, @JsonKey(fromJson: _toDouble)  double rating, @JsonKey(fromJson: _toDouble)  double discountPercentage, @JsonKey(fromJson: _toInt)  int stock, @JsonKey(fromJson: _toInt)  int price,  List<String> images)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.brand,_that.category,_that.rating,_that.discountPercentage,_that.stock,_that.price,_that.images);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _toInt)  int id,  String title,  String description,  String thumbnail,  String brand,  String category, @JsonKey(fromJson: _toDouble)  double rating, @JsonKey(fromJson: _toDouble)  double discountPercentage, @JsonKey(fromJson: _toInt)  int stock, @JsonKey(fromJson: _toInt)  int price,  List<String> images)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.thumbnail,_that.brand,_that.category,_that.rating,_that.discountPercentage,_that.stock,_that.price,_that.images);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({@JsonKey(fromJson: _toInt) this.id = 0, this.title = '', this.description = '', this.thumbnail = '', this.brand = '', this.category = '', @JsonKey(fromJson: _toDouble) this.rating = 0, @JsonKey(fromJson: _toDouble) this.discountPercentage = 0, @JsonKey(fromJson: _toInt) this.stock = 0, @JsonKey(fromJson: _toInt) this.price = 0, final  List<String> images = const []}): _images = images,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override@JsonKey(fromJson: _toInt) final  int id;
@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  String thumbnail;
@override@JsonKey() final  String brand;
@override@JsonKey() final  String category;
@override@JsonKey(fromJson: _toDouble) final  double rating;
@override@JsonKey(fromJson: _toDouble) final  double discountPercentage;
@override@JsonKey(fromJson: _toInt) final  int stock;
@override@JsonKey(fromJson: _toInt) final  int price;
 final  List<String> _images;
@override@JsonKey() List<String> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}


/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.category, category) || other.category == category)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.price, price) || other.price == price)&&const DeepCollectionEquality().equals(other._images, _images));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,thumbnail,brand,category,rating,discountPercentage,stock,price,const DeepCollectionEquality().hash(_images));

@override
String toString() {
  return 'ProductModel(id: $id, title: $title, description: $description, thumbnail: $thumbnail, brand: $brand, category: $category, rating: $rating, discountPercentage: $discountPercentage, stock: $stock, price: $price, images: $images)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _toInt) int id, String title, String description, String thumbnail, String brand, String category,@JsonKey(fromJson: _toDouble) double rating,@JsonKey(fromJson: _toDouble) double discountPercentage,@JsonKey(fromJson: _toInt) int stock,@JsonKey(fromJson: _toInt) int price, List<String> images
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? thumbnail = null,Object? brand = null,Object? category = null,Object? rating = null,Object? discountPercentage = null,Object? stock = null,Object? price = null,Object? images = null,}) {
  return _then(_ProductModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as int,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$ProductPageModel {

 List<ProductModel> get products;@JsonKey(fromJson: _toInt) int get total;@JsonKey(fromJson: _toInt) int get skip;
/// Create a copy of ProductPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductPageModelCopyWith<ProductPageModel> get copyWith => _$ProductPageModelCopyWithImpl<ProductPageModel>(this as ProductPageModel, _$identity);

  /// Serializes this ProductPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductPageModel&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(products),total,skip);

@override
String toString() {
  return 'ProductPageModel(products: $products, total: $total, skip: $skip)';
}


}

/// @nodoc
abstract mixin class $ProductPageModelCopyWith<$Res>  {
  factory $ProductPageModelCopyWith(ProductPageModel value, $Res Function(ProductPageModel) _then) = _$ProductPageModelCopyWithImpl;
@useResult
$Res call({
 List<ProductModel> products,@JsonKey(fromJson: _toInt) int total,@JsonKey(fromJson: _toInt) int skip
});




}
/// @nodoc
class _$ProductPageModelCopyWithImpl<$Res>
    implements $ProductPageModelCopyWith<$Res> {
  _$ProductPageModelCopyWithImpl(this._self, this._then);

  final ProductPageModel _self;
  final $Res Function(ProductPageModel) _then;

/// Create a copy of ProductPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? products = null,Object? total = null,Object? skip = null,}) {
  return _then(_self.copyWith(
products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductPageModel].
extension ProductPageModelPatterns on ProductPageModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductPageModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductPageModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductPageModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductPageModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<ProductModel> products, @JsonKey(fromJson: _toInt)  int total, @JsonKey(fromJson: _toInt)  int skip)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductPageModel() when $default != null:
return $default(_that.products,_that.total,_that.skip);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<ProductModel> products, @JsonKey(fromJson: _toInt)  int total, @JsonKey(fromJson: _toInt)  int skip)  $default,) {final _that = this;
switch (_that) {
case _ProductPageModel():
return $default(_that.products,_that.total,_that.skip);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<ProductModel> products, @JsonKey(fromJson: _toInt)  int total, @JsonKey(fromJson: _toInt)  int skip)?  $default,) {final _that = this;
switch (_that) {
case _ProductPageModel() when $default != null:
return $default(_that.products,_that.total,_that.skip);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductPageModel extends ProductPageModel {
  const _ProductPageModel({final  List<ProductModel> products = const [], @JsonKey(fromJson: _toInt) this.total = 0, @JsonKey(fromJson: _toInt) this.skip = 0}): _products = products,super._();
  factory _ProductPageModel.fromJson(Map<String, dynamic> json) => _$ProductPageModelFromJson(json);

 final  List<ProductModel> _products;
@override@JsonKey() List<ProductModel> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey(fromJson: _toInt) final  int total;
@override@JsonKey(fromJson: _toInt) final  int skip;

/// Create a copy of ProductPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductPageModelCopyWith<_ProductPageModel> get copyWith => __$ProductPageModelCopyWithImpl<_ProductPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductPageModel&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.total, total) || other.total == total)&&(identical(other.skip, skip) || other.skip == skip));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_products),total,skip);

@override
String toString() {
  return 'ProductPageModel(products: $products, total: $total, skip: $skip)';
}


}

/// @nodoc
abstract mixin class _$ProductPageModelCopyWith<$Res> implements $ProductPageModelCopyWith<$Res> {
  factory _$ProductPageModelCopyWith(_ProductPageModel value, $Res Function(_ProductPageModel) _then) = __$ProductPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<ProductModel> products,@JsonKey(fromJson: _toInt) int total,@JsonKey(fromJson: _toInt) int skip
});




}
/// @nodoc
class __$ProductPageModelCopyWithImpl<$Res>
    implements _$ProductPageModelCopyWith<$Res> {
  __$ProductPageModelCopyWithImpl(this._self, this._then);

  final _ProductPageModel _self;
  final $Res Function(_ProductPageModel) _then;

/// Create a copy of ProductPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? products = null,Object? total = null,Object? skip = null,}) {
  return _then(_ProductPageModel(
products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<ProductModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,skip: null == skip ? _self.skip : skip // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
