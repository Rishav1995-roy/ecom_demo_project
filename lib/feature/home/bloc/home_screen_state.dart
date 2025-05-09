part of 'home_screen_bloc.dart';

abstract class HomeScreenState  extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeScreenInitial extends HomeScreenState {}
class ProductListLoading extends HomeScreenState {}
class ProductListLoaded extends HomeScreenState {
  final List<ProductListModel> productList;

  ProductListLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

class ProductListError extends HomeScreenState {
  final String error;

  ProductListError(this.error);

  @override
  List<Object?> get props => [error];
}