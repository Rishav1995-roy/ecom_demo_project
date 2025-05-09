part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchProductsEvent extends HomeScreenEvent {
  final int offset;
  final int limit;

  FetchProductsEvent({required this.offset, required this.limit});

  @override 
  List<Object?> get props => [offset, limit];
}

class FetchCategoryEvent extends HomeScreenEvent {
  final int limit;

  FetchCategoryEvent({required this.limit});

  @override 
  List<Object?> get props => [limit];
}

class AddToCart extends HomeScreenEvent {
  final ProductListModel productListModel;

  AddToCart({required this.productListModel});

  @override 
  List<Object?> get props => [productListModel];
}

class GetCartCount extends HomeScreenEvent {

  GetCartCount();

  @override 
  List<Object?> get props => [];
}
