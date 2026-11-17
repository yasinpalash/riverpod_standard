import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/features/home/domain/entities/product.dart';

enum HomeConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts,
  endReached,
}

class HomeState extends Equatable {
  final List<Product> productList;
  final int total;
  final bool hasData;
  final HomeConcreteState state;
  /// Failure text from the domain/data layer; empty when there is no error.
  final String errorMessage;
  final bool isLoading;
  const HomeState({
    this.productList = const [],
    this.isLoading = false,
    this.hasData = false,
    this.state = HomeConcreteState.initial,
    this.errorMessage = '',
    this.total = 0,
  });
  const HomeState.initial({
    this.productList = const [],
    this.total = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = HomeConcreteState.initial,
    this.errorMessage = '',
  });

  HomeState copyWith({
    List<Product>? productList,
    int? total,
    bool? hasData,
    HomeConcreteState? state,
    String? errorMessage,
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      total: total ?? this.total,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() {
    return 'HomeState(isLoading:$isLoading, productLength: ${productList.length},total:$total, hasData: $hasData, state: $state, errorMessage: $errorMessage)';
  }

  @override
  List<Object?> get props => [productList, total, hasData, state, errorMessage];
}
