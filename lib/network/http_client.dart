import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class HttpClient {
  static const String baseUrl = 'https://api.escuelajs.co';
  static const _successCode = 200;

  FutureOr<dynamic> executeGet(
    String url,
    Map<String, String>? headers,
  ) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return Future.error('No internet connection detected');
    } else {
      try {
        var requestHeaders = {
          'Content-Type': 'application/json',
          // Add any other headers if needed
        };
        if (headers != null) {
          requestHeaders.addAll(headers);
        }
        String fullUrl = baseUrl + url;
        var res = await http.get(
          Uri.parse(fullUrl),
          headers: requestHeaders,
        );
        if (res.statusCode == _successCode) {
          return jsonDecode(res.body);
        } else {
          throw Exception('Error: ${res.statusCode}');
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  FutureOr<dynamic> executePost(
    String url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  ) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return Future.error('No internet connection detected');
    } else {
      try {
        var requestHeaders = {
          'Content-Type': 'application/json',
          // Add any other headers if needed
        };
        if (headers != null) {
          requestHeaders.addAll(headers);
        }
        var res = await http.post(
          Uri.parse(baseUrl + url),
          headers: requestHeaders,
          body: body != null ? jsonEncode(body) : null,
        );
        if (res.statusCode == _successCode) {
          return jsonDecode(res.body);
        } else {
          throw Exception('Error: ${res.statusCode}');
        }
      } catch (e) {
        rethrow;
      }
    }
  }
}
