part of 'cart_screen_bloc.dart';

abstract class CartScreenEvent  extends Equatable {
  @override
  List<Object?> get props => [];
}

class RemoveCart extends CartScreenEvent {
  final String productID;

  RemoveCart({required this.productID});

  @override 
  List<Object?> get props => [productID];
}

class FetchCartData extends CartScreenEvent {

  FetchCartData();

  @override 
  List<Object?> get props => [];
}