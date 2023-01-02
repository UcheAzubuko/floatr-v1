import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/register_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_bvn_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_phone_params.dart';
import 'package:floatr/core/data/data_source/remote/api_configs.dart';
import 'package:floatr/core/data/services/api_service.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:floatr/core/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

class AuthenticationRepository {
  final SharedPreferences prefs;

  AuthenticationRepository({required this.prefs});

  /// authHeaders
  final Map<String, String> _authHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  ///login
  Future<Either<Failure, String>> login(LoginParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.loginPath,
    );

    final loginBody = params.toMap();

    try {
      final response = await APIService.post(
        url: url,
        body: loginBody,
        headers: _authHeaders,
      );
      final body = jsonDecode(response.body);
      final accessToken = body["access_token"];
      await prefs.setString(
          StorageKeys.accessTokenKey, accessToken); // store token
      return Right(accessToken); // grab access_token
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // register
  Future<Either<Failure, String>> register(RegisterParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.registerPath,
    );

    final registerBody = params.toMap();

    try {
      final response = await APIService.post(
        url: url,
        body: registerBody,
        headers: _authHeaders,
      );
      final body = jsonDecode(response.body); // grab access_token
      final accessToken = body["access_token"];

      /// begin phone verification
      await beginPhoneVerification(accessToken);

      // store token
      await prefs.setString(
          StorageKeys.accessTokenKey, accessToken); // store token
      return Right(accessToken);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<void> beginPhoneVerification(String accessToken) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.beginPhoneVerificationPath,
    );

    final reqBody = {"mode": "sms"};

    try {
      await APIService.post(
        url: url,
        body: reqBody,
        headers: _authHeaders..addAll({"Authorization": "Bearer $accessToken"}),
      );
    } on ServerException catch (_) {
      throw const ServerFailure();
    }
  }

  /// verify phone number
  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyPhone,
    );

    final verifyPhoneBody = params.toMap();

    try {
      final accessToken = prefs.getString(StorageKeys.accessTokenKey);
      final response = await APIService.post(
        url: url,
        body: verifyPhoneBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body); // grab access_token
      return Right(body["access_token"]);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  /// verify BVN
  Future<Either<Failure, String>> verifyBVN(VerifyBVNParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyBVN,
    );

    final verifyBvnBody = params.toMap();

    try {
      final accessToken = prefs.getString(StorageKeys.accessTokenKey);
      final response = await APIService.post(
        url: url,
        body: verifyBvnBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      return Right(body["access_token"]);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, bool>> uploadPicture(File imageFile) async {
    // final convertedImageFile =
    //     await PictureUploadService.convertToWebp(imageFile);

    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.filesUploadPath,
    );

    final reqBody = {
      "ext": "jpg",
      "name": basename(imageFile.path),
      "purpose": "user/profile/pictures",
      "size": await imageFile.length(),
      "type": "image_jpg",
    };

    // prepare upload
    try {
      final accessToken = prefs.getString(StorageKeys.accessTokenKey);
      final response = await APIService.post(
        url: url,
        body: reqBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);

      // upload to bucket
      try {
        final imageUploadHeader = {
          "Content-Type": "octet-stream",
          "Content-Length": imageFile.lengthSync().toString()
        };

        List<int> imageData = await imageFile.readAsBytes();

        final uploadReqest = await APIService.put(
            url: Uri.parse(body["url"]),
            body: imageData,
            headers: imageUploadHeader);

        final putBody = {
          "id": body["id"],
          "completedParts": [
            {"ETag": uploadReqest.headers["etag"], "PartNumber": 1}
          ],
          "type": "single",
        };
        // complete request
        try {
          final response = await APIService.put(
            url: url,
            body: jsonEncode(putBody),
            headers: _authHeaders, // add access token authorization to header
          );
          log('Completed request ${response.statusCode}');
        } on ServerException catch (_) {
          return Left(
              ServerFailure(code: _.code.toString(), message: _.message));
        }
      } on ServerException catch (_) {
        return Left(ServerFailure(code: _.code.toString(), message: _.message));
      }
      return const Right(true);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    } catch (e) {
      throw Exception(e);
    }
  }
}
