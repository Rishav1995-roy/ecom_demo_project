part of 'product_details_screen_bloc.dart';

abstract class ProductDetailsScreenEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsDetailsEvent extends ProductDetailsScreenEvent {
  final int productID;

  FetchProductsDetailsEvent({required this.productID});

  @override 
  List<Object?> get props => [productID];
}

class FetchSimilarProductEvent extends ProductDetailsScreenEvent {
  final int productID;

  FetchSimilarProductEvent({required this.productID});

  @override 
  List<Object?> get props => [productID];
}

class AddToCart extends ProductDetailsScreenEvent {
  final ProductListModel productListModel;

  AddToCart({required this.productListModel});

  @override 
  List<Object?> get props => [productListModel];
}