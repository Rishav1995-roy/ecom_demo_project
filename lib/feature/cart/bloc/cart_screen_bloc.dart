import 'package:ecom_demo/models/cart_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_screen_event.dart';
part 'cart_screen_state.dart';

class CartScreenBloc extends Bloc<CartScreenEvent, CartScreenState> {

  late HomeRepository _homeRepository;

  CartScreenBloc({
    required HomeRepository homeRepository,
  }): super(CartScreenInitial()) {
    _homeRepository = homeRepository;
    on<RemoveCart>(_removeCart);
    on<FetchCartData>(_fetchCartData);
  }

  void _fetchCartData(
    FetchCartData event,
    Emitter<CartScreenState> emit,
  ) async {
    emit(CartListLoading());
    try {
      final List<CartData> cartList = _homeRepository.getCartItems();
      emit(CartListLoaded(cartList));
    } catch (e) {
      emit(CartListError(e.toString()));
    }
  }

  void _removeCart(
    RemoveCart event,
    Emitter<CartScreenState> emit,
  ) async {
    await _homeRepository.removeFromCart(productID: event.productID);
    add(FetchCartData());
  }


}