import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_standard/core/constants/api_constants.dart';
import 'package:riverpod_standard/features/home/presentation/providers/state/home_state.dart';
import 'package:riverpod_standard/shared/models/either.dart';
import 'package:riverpod_standard/shared/models/paginated_response.dart';
import 'package:riverpod_standard/features/home/domain/models/product/product_model.dart';
import 'package:riverpod_standard/core/errors/exceptions.dart';
import 'package:riverpod_standard/core/localization/locale_keys.g.dart';
import '../../../domain/repositories/home_repository.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository homeRepository;

  HomeNotifier(this.homeRepository) : super(const HomeState.initial());
  bool get isFetching =>
      state.state != HomeConcreteState.loading &&
      state.state != HomeConcreteState.fetchingMore;

  Future<void> fetchProducts() async {
    if (isFetching && state.state != HomeConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state:
            state.page > 0
                ? HomeConcreteState.fetchingMore
                : HomeConcreteState.loading,
        isLoading: true,
      );

      final response = await homeRepository.fetchProducts(
        skip: state.page * ApiConstants.productsPerPage,
      );
      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: HomeConcreteState.fetchedAllProducts,
        message: LocaleKeys.home_no_more_products_available,
        isLoading: false,
      );
    }
  }

  Future<void> searchProducts(String query) async {
    if (isFetching && state.state != HomeConcreteState.fetchedAllProducts) {
      state = state.copyWith(
        state:
            state.page > 0
                ? HomeConcreteState.fetchingMore
                : HomeConcreteState.loading,
        isLoading: true,
      );

      final response = await homeRepository.searchProducts(
        skip: state.page * ApiConstants.productsPerPage,
        query: query,
      );

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: HomeConcreteState.fetchedAllProducts,
        message: LocaleKeys.home_no_more_products_available,
        isLoading: false,
      );
    }
  }

  void updateStateFromResponse(
    Either<AppException, PaginatedResponse<Product>> response,
  ) {
    response.fold(
      (failure) {
        state = state.copyWith(
          state: HomeConcreteState.failure,
          message: failure.message,
          isLoading: false,
        );
      },
      (data) {
        final totalProducts = [...state.productList, ...data.data];
        state = state.copyWith(
          productList: totalProducts,
          state:
              totalProducts.length == data.total
                  ? HomeConcreteState.fetchedAllProducts
                  : HomeConcreteState.loaded,
          hasData: true,
          message:
              totalProducts.isEmpty ? LocaleKeys.home_no_products_found : '',
          page: totalProducts.length ~/ ApiConstants.productsPerPage,
          total: data.total,
          isLoading: false,
        );
      },
    );
  }

  void resetState() {
    state = const HomeState.initial();
  }
}
