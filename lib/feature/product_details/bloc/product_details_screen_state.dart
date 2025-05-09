part of 'product_details_screen_bloc.dart';

abstract class ProductDetailsScreenState  extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailsScreenInitial extends ProductDetailsScreenState {}

class SimilarProductListLoading extends ProductDetailsScreenState {}
class SimilarProductListLoaded extends ProductDetailsScreenState {
  final List<ProductListModel> productList;

  SimilarProductListLoaded(this.productList);

  @override
  List<Object?> get props => [productList];
}

class SimilarProductListError extends ProductDetailsScreenState {
  final String error;

  SimilarProductListError(this.error);

  @override
  List<Object?> get props => [error];
}

class ProductDetailsLoading extends ProductDetailsScreenState {}
class ProductDetailsLoaded extends ProductDetailsScreenState {
  final ProductListModel productData;

  ProductDetailsLoaded(this.productData);

  @override
  List<Object?> get props => [productData];
}

class ProductDetailsError extends ProductDetailsScreenState {
  final String error;

  ProductDetailsError(this.error);

  @override
  List<Object?> get props => [error];
}