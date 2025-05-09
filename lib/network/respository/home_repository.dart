import 'package:ecom_demo/models/category_list_model.dart';
import 'package:ecom_demo/models/product_list_model.dart';
import 'package:ecom_demo/network/end_points_service.dart';
import 'package:ecom_demo/network/services/home_services.dart';

class HomeRepository {
  final HomeServices _homeServices;

  HomeRepository(this._homeServices);

  Future<List<ProductListModel>> getProducts({
    required int offset,
    required int limit,
  }) async {
    try {
      final response = await _homeServices.getProducts(
        url: '${EndPointsService.getProductDetails}?limit=$limit&offset=$offset',
      );
      List<ProductListModel> productList = response
          .map<ProductListModel>((json) => ProductListModel.fromJson(json))
          .toList();
      return productList;    
    } catch (e) {
      rethrow;
    }
  } 

  Future<List<CategoryListModel>> getCategories({
    required int limit,
  }) async {
    try {
      final response = await _homeServices.getCategories(
        url: '${EndPointsService.getCategoryList}?limit=$limit',
      );
      List<CategoryListModel> categoryList = response
          .map<CategoryListModel>((json) => CategoryListModel.fromJson(json))
          .toList();
      return categoryList;    
    } catch (e) {
      rethrow;
    }
  } 

  Future<List<ProductListModel>> getCategoryProducts({
    required int offset,
    required int limit,
    required int categoryId,
  }) async {
    try {
      final response = await _homeServices.getCategoryProducts(
        url: '${EndPointsService.getCategoryDetails}$categoryId/products?limit=$limit&offset=$offset',
      );
      List<ProductListModel> productList = response
          .map<ProductListModel>((json) => ProductListModel.fromJson(json))
          .toList();
      return productList;    
    } catch (e) {
      rethrow;
    }
  } 
}