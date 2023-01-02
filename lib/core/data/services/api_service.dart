// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
// import 'dart:html' as html;
import 'dart:io';

import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart' as httpParser;
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
            'A client-side error occured. ${json.decode(response.body)}',
            response.statusCode);
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        throw ServerException(
            'A server-side error occured.', response.statusCode);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message, e.code);
    } catch (e) {
      throw ServerException(e.toString(), 0);
    }
    throw ServerException('An unknown error occured', 0);
  }

  static Future<http.Response> put({
    required Uri url,
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.put(url,
          headers: headers ?? {}, body: body);

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response;
      } else if (response.statusCode >= 400 && response.statusCode <= 499) {
        // print(response.body);
        throw ServerException(
            'A client-side error occured. ${json.decode(response.body)}',
            response.statusCode);
      } else if (response.statusCode >= 500 && response.statusCode <= 599) {
        throw ServerException(
            'A server-side error occured. ${json.decode(response.body)}',
            response.statusCode);
      }
    } on ServerException catch (e) {
      throw ServerException(e.message, e.code);
    } catch (e) {
      throw ServerException(e.toString(), 0);
    }
    throw ServerException('An unknown error occured', 0);
  }

  static Future<http.Response> uploadFile(
      String uri, File file, headers) async {
    // html.HttpRequest httpRequest =
    //     await html.HttpRequest.request(uri, method: 'PUT');

    // httpRequest..open('PUT', uri)..onLoadEnd.listen((event) => print('${event.loaded}'))..send(file);
    try {
      // final request = http.MultipartRequest("PUT", Uri.parse(uri))
      //   ..files.add(await http.MultipartFile.fromPath(
      //       'image', file.absolute.path,
      //       contentType: httpParser.MediaType('image', 'jpg')));
      // // request.headers.addAll(headers);
      // var streamedResponse = await request.send();
      // final response = await http.Response.fromStream(streamedResponse);

      // print(file.absolute.path);
      // if (streamedResponse.statusCode == 200) {
      //   print('File Uploaded');
      //   print('response header: ${streamedResponse.headers}');
      // } else {
      //   print('File upload error code:${streamedResponse.statusCode}');
      //   print(streamedResponse.reasonPhrase);
      //   print(streamedResponse.request);
      //   print('The body${response.body}');
      //   // throw ServerException(
      //   //     'A file upload error occured.', response.statusCode);
      // }

      // HttpRequest httpRequest =
      //     await HttpRequest().
      //     .request(uri, method: 'PUT', sendData: file);

      // if (httpRequest.status == 200) {
      //   print('Fuck, it worked');
      // } else {
      //   print('The Error fuck! ${httpRequest.response}');
      // }
      List<int> imageData = await file.readAsBytes();

      final imageHeader = {
        "Content-Type": "octet-stream",
        "Content-Length": file.lengthSync().toString()
      };

      final response =
          await http.put(Uri.parse(uri), headers: imageHeader, body: imageData);
      if (response.statusCode == 200) {
        return response;
      } else {
      }
    } on ServerException catch (e) {
      throw ServerException(e.message, e.code);
    } catch (e) {
      throw ServerException(e.toString(), 0);
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