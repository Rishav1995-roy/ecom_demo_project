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
}
