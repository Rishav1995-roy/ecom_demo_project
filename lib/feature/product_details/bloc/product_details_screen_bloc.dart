import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_screen_event.dart';
part 'product_details_screen_state.dart';

class ProductDetailsScreenBloc extends Bloc<ProductDetailsScreenEvent, ProductDetailsScreenState> {

  late HomeRepository _homeRepository;

  ProductDetailsScreenBloc({
    required HomeRepository homeRepository,
  }): super(ProductDetailsScreenInitial()) {
    _homeRepository = homeRepository;
    on<FetchProductsDetailsEvent>(_onFetchProductsDetails);
    on<FetchSimilarProductEvent>(_onFetchSimilarProducts);
    on<AddToCart>(_addToCart);
  }

  void _addToCart(
    AddToCart event,
    Emitter<ProductDetailsScreenState> emit,
  ) async {
    await _homeRepository.addToCart(data: event.productListModel);
  }

  void _onFetchProductsDetails(
    FetchProductsDetailsEvent event,
    Emitter<ProductDetailsScreenState>emit,
  ) async {
    emit(ProductDetailsLoading());
    try {
      final ProductListModel productData = await _homeRepository.getProductsDetails(
        productID: event.productID,
      );
      emit(ProductDetailsLoaded(productData));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  void _onFetchSimilarProducts(
    FetchSimilarProductEvent event,
    Emitter<ProductDetailsScreenState>emit,
  ) async {
    emit(ProductDetailsLoading());
    try {
      final List<ProductListModel> productList = await _homeRepository.getSimilarProducts(
        productID: event.productID,
      );
      emit(SimilarProductListLoaded(productList));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

}