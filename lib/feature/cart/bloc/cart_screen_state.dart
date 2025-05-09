part of 'cart_screen_bloc.dart';

abstract class CartScreenState  extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartScreenInitial extends CartScreenState {}

class CartListLoading extends CartScreenState {}
class CartListLoaded extends CartScreenState {
  final List<CartData> cartData;

  CartListLoaded(this.cartData);

  @override
  List<Object?> get props => [cartData];
}

class CartListError extends CartScreenState {
  final String error;

  CartListError(this.error);

  @override
  List<Object?> get props => [error];
}