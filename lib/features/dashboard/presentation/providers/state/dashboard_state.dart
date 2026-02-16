import 'package:equatable/equatable.dart';

enum DashboardConcreteState {
  initial,
  loading,
  loaded,
  failure,
  fetchingMore,
  fetchedAllProducts,
}

class DashboardState extends Equatable {
final List<Product> productList;
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
