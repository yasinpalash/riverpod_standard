import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/result/either.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/core/usecases/usecase.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_listing.dart';
import 'package:riverpod_standard/features/home/domain/repositories/home_repository.dart';

/// Loads the next page and returns the listing with it appended.
/// Returns the listing unchanged when everything is already loaded.
class FetchProducts extends UseCase<ProductListing, ProductListing> {
  const FetchProducts(this._repository);
  final HomeRepository _repository;

  @override
  ResultFuture<ProductListing> call(ProductListing params) async {
    if (!params.hasMore) return Right(params);
    final result = await _repository.fetchProducts(
      skip: params.nextSkip,
      limit: ProductListing.pageSize,
    );
    return result.map(params.append);
  }
}

class SearchProductsParams extends Equatable {
  const SearchProductsParams({required this.current, required this.query});
  final ProductListing current;
  final String query;

  @override
  List<Object?> get props => [current, query];
}

class SearchProducts extends UseCase<ProductListing, SearchProductsParams> {
  const SearchProducts(this._repository);
  final HomeRepository _repository;

  @override
  ResultFuture<ProductListing> call(SearchProductsParams params) async {
    final current = params.current;
    if (!current.hasMore) return Right(current);
    final result = await _repository.searchProducts(
      skip: current.nextSkip,
      limit: ProductListing.pageSize,
      query: params.query,
    );
    return result.map(current.append);
  }
}
