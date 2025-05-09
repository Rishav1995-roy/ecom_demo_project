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
}