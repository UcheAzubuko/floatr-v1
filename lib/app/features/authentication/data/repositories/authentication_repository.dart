import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/authentication/data/model/params/reset_password_params.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/register_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_bvn_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_phone_params.dart';
import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';
import 'package:floatr/core/data/data_source/remote/api_configs.dart';
import 'package:floatr/core/data/services/api_service.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:floatr/core/errors/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';

import '../../../../../core/utils/enums.dart';

class AuthenticationRepository {
  final SharedPreferences _prefs;
  final APIService _apiService;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthenticationRepository(
      {required SharedPreferences prefs,
      required APIService apiService,
      required FlutterSecureStorage flutterSecureStorage})
      : _prefs = prefs,
        _apiService = apiService,
        _flutterSecureStorage = flutterSecureStorage;

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
      final response = await _apiService.post(
        url: url,
        body: loginBody,
        headers: _authHeaders,
      );
      final body = jsonDecode(response.body);
      final accessToken = body["access_token"];
      await _prefs.setString(
          StorageKeys.accessTokenKey, accessToken); // store token

      // store pass and email
      _flutterSecureStorage
        ..write(key: StorageKeys.emailKey, value: params.email)
        ..write(key: StorageKeys.passKey, value: params.password);
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
      final response = await _apiService.post(
        url: url,
        body: registerBody,
        headers: _authHeaders,
      );
      final body = jsonDecode(response.body); // grab access_token
      final accessToken = body["access_token"];

      // store token
      await _prefs.setString(StorageKeys.accessTokenKey, accessToken);

      // store pass and email
      _flutterSecureStorage
        ..write(key: StorageKeys.emailKey, value: params.email)
        ..write(key: StorageKeys.passKey, value: params.password);

      /// begin phone verification
      await beginPhoneVerification();

      return Right(accessToken);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  bool _isLoggedIn() =>
      _prefs.containsKey(StorageKeys.accessTokenKey) &&
      !JwtDecoder.isExpired(_prefs.getString(StorageKeys.accessTokenKey)!);

  bool get isLoggedIn => _isLoggedIn();

  Future<Either<Failure, bool>> beginPhoneVerification() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.beginPhoneVerificationPath,
    );

    final reqBody = {"mode": "sms"};
    final accessToken = _prefs.getString(StorageKeys.accessTokenKey);

    try {
      await _apiService.post(
        url: url,
        body: reqBody,
        headers: _authHeaders..addAll({"Authorization": "Bearer $accessToken"}),
      );
      return const Right(true);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> biometricLogin() async {
    final email = await _flutterSecureStorage.read(key: StorageKeys.emailKey);
    final password = await _flutterSecureStorage.read(key: StorageKeys.passKey);
    return login(LoginParams(email: email, password: password));
  }

  /// verify phone number
  Future<Either<Failure, String>> verifyPhone(VerifyPhoneParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyPhonePath,
    );

    final verifyPhoneBody = params.toMap();

    try {
      String? accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: verifyPhoneBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body); // grab access_token
      accessToken = body["access_token"]; // update token
      await _prefs.setString(
          StorageKeys.accessTokenKey, accessToken!); // store new token
      return Right(accessToken);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  /// verify BVN
  Future<Either<Failure, String>> verifyBVN(VerifyBVNParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyBVNPath,
    );

    final verifyBvnBody = params.toMap();

    try {
      String? accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: verifyBvnBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"]; // update token
      await _prefs.setString(
          StorageKeys.accessTokenKey, accessToken!); // store new token
      return Right(body["access_token"]);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, UserResponse>> getUser() async {
    final url = Uri.parse(APIConfigs.userFullPath);
    try {
      String? accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
          url: url,
          headers: _authHeaders
            ..addAll({"Authorization": "Bearer ${accessToken!}"}));
      return Right(UserResponse.fromRawJson(response.body));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    } catch (_) {
      return Left(ServerFailure(code: '0', message: _.toString()));
    }
  }

  Future<Either<Failure, String>> createPin(String transactionPin) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.user,
    );

    final createPinBody = {"pin": transactionPin};

    try {
      String? accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: createPinBody,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"];
      await _prefs.setString(StorageKeys.accessTokenKey, accessToken!);
      return Right(body["access_token"]);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, bool>> uploadPicture(
      File imageFile, ImageType imageType,
      [DocumentType documentType = DocumentType.driverLicense]) async {
    // final convertedImageFile =
    //     await PictureUploadService.convertToWebp(imageFile);

    final bool isSelfie = imageType == ImageType.selfie;

    final filesUploadUrl = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.filesUploadPath,
    );

    final reqBody = {
      "ext": "jpg",
      "name": basename(imageFile.path),
      "purpose":
          isSelfie ? "user/profile/pictures" : chooseImagePath(documentType),
      "size": await imageFile.length(),
      "type": "image_jpg",
    };

    // prepare upload
    try {
      final accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: filesUploadUrl,
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

        final uploadReqest = await _apiService.put(
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
          final response = await _apiService.put(
            url: filesUploadUrl,
            body: jsonEncode(putBody),
            headers: _authHeaders, // add access token authorization to header
          );
          log('Completed request ${response.statusCode}');

          final saveSelfieUrl = Uri.https(
            APIConfigs.baseUrl,
            APIConfigs.saveSelfiePath,
          );

          final saveDocumentUrl = Uri.https(
            APIConfigs.baseUrl,
            APIConfigs.saveDocumentPath,
          );

          try {
            final saveFileBody = {
              "fileId": body["id"],
            };
            // save selfie
            await _apiService.post(
                url: isSelfie ? saveSelfieUrl : saveDocumentUrl,
                body: saveFileBody,
                headers: _authHeaders);
          } on ServerException catch (_) {
            return Left(
                ServerFailure(code: _.code.toString(), message: _.message));
          }
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

  Future<Either<Failure, bool>> forgotPassword(
      ResetPasswordParams params) async {
    final forgotPasswordUrl = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.forgotPassword,
    );

    final body = {"phoneNumber": params.phoneNumber};

    try {
      // final accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      await _apiService.post(
        url: forgotPasswordUrl,
        body: body,
      );
      return const Right(true);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, bool>> verifyForgotPasswordToken(
      ResetPasswordParams params) async {
    final forgotPasswordUrl = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyForgotPasswordToken,
    );

    final body = {"token": params.token, "phoneNumber": params.phoneNumber};

    try {
      final accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      await _apiService.post(
        url: forgotPasswordUrl,
        body: body,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      return const Right(true);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, bool>> resetPassword(
      ResetPasswordParams params) async {
    final forgotPasswordUrl = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.resetPassword,
    );

    final body = params.toMap();

    try {
      final accessToken = _prefs.getString(StorageKeys.accessTokenKey);
      await _apiService.post(
        url: forgotPasswordUrl,
        body: body,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      return const Right(true);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }
}

String chooseImagePath(DocumentType documentType) {
  switch (documentType) {
    case DocumentType.driverLicense:
      return "user/government/issued/driver-license/ids";
    case DocumentType.internationalPassport:
      return "user/government/issued/international-passport/ids";
    case DocumentType.nationalIdentityCard:
      return "user/government/issued/national/ids";
    case DocumentType.votersCard:
      return "user/government/issued/voters-card/ids";
    default:
      return "user/government/issued/driver-license/ids";
  }
}
