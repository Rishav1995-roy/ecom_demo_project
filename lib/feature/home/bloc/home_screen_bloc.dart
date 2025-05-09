import 'package:ecom_demo/models/category_list_model.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {

  late HomeRepository _homeRepository;

  HomeScreenBloc({
    required HomeRepository homeRepository,
  }): super(HomeScreenInitial()) {
    _homeRepository = homeRepository;
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchCategoryEvent>(_onFetchCategory);
    on<AddToCart>(_addToCart);
    on<GetCartCount>(_getCartCount);
  }

  void _getCartCount(
    GetCartCount event,
    Emitter<HomeScreenState> emit,
  ) async {
    _homeRepository.getCount();
  }

  void _addToCart(
    AddToCart event,
    Emitter<HomeScreenState> emit,
  ) async {
    await _homeRepository.addToCart(data: event.productListModel);
  }

  ValueStream<int> get cartCountStream =>
      _homeRepository.cartCountDataStream;

  void _onFetchProducts(
    FetchProductsEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(ProductListLoading());
    try {
      final List<ProductListModel> productList = await _homeRepository.getProducts(
        limit: event.limit,
        offset: event.offset,
      );
      emit(ProductListLoaded(productList));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }

  void _onFetchCategory(
    FetchCategoryEvent event,
    Emitter<HomeScreenState> emit,
  ) async {
    emit(CategoryListLoading());
    try {
      final List<CategoryListModel> categoryList = await _homeRepository.getCategories(
        limit: event.limit,
      );
      emit(CategoryListLoaded(categoryList));
    } catch (e) {
      emit(CategoryListError(e.toString()));
    }
  }


}