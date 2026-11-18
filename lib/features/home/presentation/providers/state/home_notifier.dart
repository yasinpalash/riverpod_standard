import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/typedefs/typedefs.dart';
import 'package:riverpod_standard/features/home/di/home_di.dart';
import 'package:riverpod_standard/features/home/domain/entities/product_listing.dart';
import 'package:riverpod_standard/features/home/domain/usecases/product_usecases.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';

class HomeNotifier extends Notifier<HomeState> {
  /// Bumped on every reset so a response from an older request is dropped
  /// instead of overwriting newer state.
  int _generation = 0;
  String? _query;

  @override
  HomeState build() {
    _generation = 0;
    _query = null;
    Future.microtask(fetchProducts);
    return const HomeState.initial();
  }

  ProductListing get _listing =>
      state.hasData
          ? ProductListing(products: state.productList, total: state.total)
          : const ProductListing();

  bool get _isBusy =>
      state.state == HomeConcreteState.loading ||
      state.state == HomeConcreteState.fetchingMore;

  Future<void> fetchProducts() =>
      _load((listing) => ref.read(fetchProductsProvider)(listing));

  /// Searches for [query]. A different query than the previous one starts a
  /// fresh result list; the same query loads the next page.
  Future<void> searchProducts(String query) {
    if (query != _query) {
      resetState();
      _query = query;
    }
    return _load(
      (listing) => ref.read(searchProductsProvider)(
        SearchProductsParams(current: listing, query: query),
      ),
    );
  }

  Future<void> _load(
    ResultFuture<ProductListing> Function(ProductListing listing) load,
  ) async {
    if (_isBusy) return;
    final listing = _listing;
    if (!listing.hasMore) {
      state = state.copyWith(
        state: HomeConcreteState.endReached,
        isLoading: false,
      );
      return;
    }

    final generation = _generation;
    state = state.copyWith(
      clearFailure: true,
      state:
          listing.isEmpty
              ? HomeConcreteState.loading
              : HomeConcreteState.fetchingMore,
      isLoading: true,
    );
    final result = await load(listing);
    if (generation != _generation) return; // stale response
    _apply(result);
  }

  void _apply(Result<ProductListing> result) {
    result.fold(
      (failure) {
        state = state.copyWith(
          state: HomeConcreteState.failure,
          failure: failure,
          isLoading: false,
        );
      },
      (listing) {
        state = state.copyWith(
          productList: listing.products,
          state:
              listing.hasMore
                  ? HomeConcreteState.loaded
                  : HomeConcreteState.fetchedAllProducts,
          hasData: true,
          total: listing.total ?? 0,
          isLoading: false,
        );
      },
    );
  }

  void resetState() {
    _generation++;
    _query = null;
    state = const HomeState.initial();
  }
}
