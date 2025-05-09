import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/respository/home_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_screen_event.dart';
part 'category_screen_state.dart';

class CategoryScreenBloc extends Bloc<CategoryScreenEvent, CategoryScreenState> {

  late HomeRepository _homeRepository;

  CategoryScreenBloc({
    required HomeRepository homeRepository,
  }): super(CategoryScreenInitial()) {
    _homeRepository = homeRepository;
    on<FetchCategoryProductsEvent>(_onFetchProducts);
  }

  void _onFetchProducts(
    FetchCategoryProductsEvent event,
    Emitter<CategoryScreenState>emit,
  ) async {
    emit(ProductListLoading());
    try {
      final List<ProductListModel> productList = await _homeRepository.getCategoryProducts(
        limit: event.limit,
        offset: event.offset,
        categoryId: event.categoryId,
      );
      emit(ProductListLoaded(productList));
    } catch (e) {
      emit(ProductListError(e.toString()));
    }
  }

}