import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/profile/data/model/params/employer_information_params.dart';
import 'package:floatr/app/features/profile/data/model/params/next_of_kin_params.dart';
import 'package:floatr/app/features/profile/data/model/params/residential_address_params.dart';
import 'package:floatr/app/features/profile/data/model/params/user_profile_params.dart';
import 'package:floatr/core/data/data_source/remote/api_configs.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/services/api_service.dart';
import '../../../../../core/errors/failure.dart';
import '../model/params/change_password_params.dart';

class ProfileRepository {
  final SharedPreferences _sharedPreferences;
  final APIService _apiService;

  ProfileRepository(
      {required SharedPreferences sharedPreferences,
      required APIService apiService})
      : _sharedPreferences = sharedPreferences,
        _apiService = apiService;

  /// authHeaders
  final Map<String, String> _authHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  // update profile
  Future<Either<Failure, String>> updateUserProfile(
      UserProfileParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.user,
    );

    final userParams = params.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: userParams
          ..containsKey('email')
          ..removeWhere((key, value) =>
              key == 'email'), // remove email since we are not updating it
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"];
      return Right(accessToken!);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // update residential adress
  Future<Either<Failure, String>> updateResidentialAddress(
      ResidentialAddressParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.user,
    );

    final residentialAddress = params.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: residentialAddress,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"];
      return Right(accessToken!);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // update employment details
  Future<Either<Failure, String>> updateEmployerInformation(
      EmployerInformationParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.employmentPath,
    );

    final employmentParams = params.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);

      final response = await _apiService.post(
        url: url,
        body: employmentParams,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"];
      return Right(accessToken!);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // update next of kin
  Future<Either<Failure, String>> updateNextOfKin(
      NextOfKinParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.nextOfKinPath,
    );

    final nextOfKinParams = params.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: nextOfKinParams,
        headers: _authHeaders
          ..addAll({
            "Authorization": "Bearer ${accessToken!}"
          }), // add access token authorization to header
      );
      final body = jsonDecode(response.body);
      accessToken = body["access_token"];
      return Right(accessToken!);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

    Future<Either<Failure, String>> changePassword(
      ChangePasswordParams changePasswordParams) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.passwordPath,
    );

    final params = changePasswordParams.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.patch(
        url: url,
        body: params,
        headers: _authHeaders..addAll({"Authorization": "Bearer ${accessToken!}"})..remove("Content-Type"),
      );
      return Right(response.body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> changePin(
      ChangePinParams changePinParams) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.pinPath,
    );

    final params = changePinParams.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.patch(
        url: url,
        body: params,
        headers: _authHeaders..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(response.body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }
}
