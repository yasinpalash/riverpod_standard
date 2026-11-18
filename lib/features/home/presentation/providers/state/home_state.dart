import 'package:equatable/equatable.dart';
import 'package:riverpod_standard/core/errors/failures.dart';
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
  /// Last failure, or `null`. The widget maps it to text via `userMessage`.
  final Failure? failure;
  final bool isLoading;
  const HomeState({
    this.productList = const [],
    this.isLoading = false,
    this.hasData = false,
    this.state = HomeConcreteState.initial,
    this.failure,
    this.total = 0,
  });
  const HomeState.initial({
    this.productList = const [],
    this.total = 0,
    this.isLoading = false,
    this.hasData = false,
    this.state = HomeConcreteState.initial,
    this.failure,
  });

  HomeState copyWith({
    List<Product>? productList,
    int? total,
    bool? hasData,
    HomeConcreteState? state,
    Failure? failure,
    bool clearFailure = false,
    bool? isLoading,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      productList: productList ?? this.productList,
      total: total ?? this.total,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      failure: clearFailure ? null : (failure ?? this.failure),
    );
  }

  @override
  String toString() {
    return 'HomeState(isLoading:$isLoading, productLength: ${productList.length},total:$total, hasData: $hasData, state: $state, failure: $failure)';
  }

  @override
  List<Object?> get props => [productList, total, hasData, state, failure];
}
