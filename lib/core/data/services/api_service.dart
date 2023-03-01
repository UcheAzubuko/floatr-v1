import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../errors/exception.dart';

class APIService {
  /// get call
  Future<http.Response> get(
      {required Uri url, Map<String, String>? headers}) async {
    final response =
        await http.get(url, headers: headers ?? {}).catchError((_) {
      throw ServerException('Connection Error', 0);
    });
    return _handleResponse(response);
  }

  Future<http.Response> post({
    required Uri url,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    // try {
    final response = await http
        .post(url, headers: headers ?? {}, body: json.encode(body ?? {}))
        .catchError((_) {
      throw ServerException('Connection Error', 0);
    });
    return _handleResponse(response);
  }

  Future<http.Response> put({
    required Uri url,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final response =
        await http.put(url, headers: headers ?? {}, body: body).catchError((_) {
      throw ServerException('Connection Error ${_.toString()}', 0);
    });
    return _handleResponse(response);
  }

  Future<http.Response> patch({
    required Uri url,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    final response =
        await http.patch(url, headers: headers ?? {}, body: body).catchError((_) {
      throw ServerException('Connection Error ${_.toString()}', 0);
    });
    return _handleResponse(response);
  }

  /// Handle response
  http.Response _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return response;
    }
    final errorBody = jsonDecode(response.body);
    String errorMessage = 'An error occured';

    if (errorBody is Map && errorBody.containsKey("errors")) {
      errorMessage = errorBody["errors"].values.join('.\n');
    } else if (errorBody is Map && errorBody.containsKey('message')){
      errorMessage = errorBody["message"];
    }
    log('Handler $errorMessage');
    throw ServerException(errorMessage, response.statusCode);
  }
}
