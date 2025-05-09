part of 'category_screen_bloc.dart';

abstract class CategoryScreenState  extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryScreenInitial extends CategoryScreenState {}
class ProductListLoading extends CategoryScreenState {}
class ProductListLoaded extends CategoryScreenState {
  final List<ProductListModel> productList;

  ProductListLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

class ProductListError extends CategoryScreenState {
  final String error;

  ProductListError(this.error);

  @override
  List<Object?> get props => [error];
}