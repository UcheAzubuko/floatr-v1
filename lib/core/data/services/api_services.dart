import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../errors/exception.dart';

class APIService {
  /// get call
  static Future<http.Response> get(
      {required Uri url, Map<String, String>? headers}) async {
    try {
      final response = await http.get(url, headers: headers ?? {});

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        throw ServerException(
            'A client-side error occured.', response.statusCode);
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        throw ServerException(
            'A server-side error occured.', response.statusCode);
      }
    } catch (e) {
      throw ServerException('An unknown error occured', 0);
    }
    throw ServerException('An unknown error occured', 0);
  }

  static Future<http.Response> post({
    required Uri url,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(url,
          headers: headers ?? {}, body: json.encode(body ?? {}));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        throw ServerException(
            'A client-side error occured.', response.statusCode);
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        throw ServerException(
            'A server-side error occured.', response.statusCode);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message, e.code);
    } catch (e) {
      throw ServerException('An unknown error occured', 0);
    }
    throw ServerException('An unknown error occured', 0);
  }
}

// 400 = client
// 500 = server

//  {
//             "Authorization":
//                 "Bearer sk_test_f453fc959ccc1c990a2e5a8838ecf208fd70ffcd",
//             "Content-Type": "application/json"
//           },