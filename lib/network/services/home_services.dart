import 'package:ecom_demo/network/http_client.dart';

class HomeServices {
  final HttpClient _httpClient;
  HomeServices(this._httpClient);

  Future<dynamic> getProducts({
    required String url,
  }) async {
    try {
      final response = await _httpClient.executeGet(
        url,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCategories({
    required String url,
  }) async {
    try {
      final response = await _httpClient.executeGet(
        url,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getCategoryProducts({
    required String url,
  }) async {
    try {
      final response = await _httpClient.executeGet(
        url,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getProductDetails({
    required String url,
  }) async {
    try {
      final response = await _httpClient.executeGet(
        url,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getSimilarProducts({
    required String url,
  }) async {
    try {
      final response = await _httpClient.executeGet(
        url,
        null,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
