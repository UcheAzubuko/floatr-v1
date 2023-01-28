import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/profile/data/model/responses/country_repsonse.dart';
import 'package:floatr/app/features/profile/data/model/responses/gender_response.dart';
import 'package:floatr/app/features/profile/data/model/responses/marital_status_response.dart';
import 'package:floatr/app/features/profile/data/model/responses/state_repsonse.dart';
import 'package:floatr/core/data/services/api_service.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/data_source/remote/api_configs.dart';
import '../../../../../core/errors/failure.dart';

class UserResourcesRepository {
  final SharedPreferences _sharedPreferences;
  final APIService _apiService;

  UserResourcesRepository(
      {required SharedPreferences sharedPreferences,
      required APIService apiService})
      : _sharedPreferences = sharedPreferences,
        _apiService = apiService;

  /// authHeaders
  final Map<String, String> _authHeaders = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  // get countries
  Future<Either<Failure, CountryResponse>> getCountries() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.countriesPath,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
          url: url,
          headers: _authHeaders
            ..addAll({"Authorization": "Bearer ${accessToken!}"}));

      final body = CountryResponse.fromMap(jsonDecode(response.body));
      return Right(body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // get states
  Future<Either<Failure, StateResponse>> getStates(String countryCode) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.states(countryCode),
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
          url: url,
          headers: _authHeaders
            ..addAll({"Authorization": "Bearer ${accessToken!}"}));

      final body = StateResponse.fromMap(jsonDecode(response.body));
      return Right(body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // get marital status
  Future<Either<Failure, MaritalStatusResponse>> getMaritalStatus() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.maritalStatusPath,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
          url: url,
          headers: _authHeaders
            ..addAll({"Authorization": "Bearer ${accessToken!}"}));

      final body = MaritalStatusResponse.fromMap(jsonDecode(response.body));
      return Right(body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  // get genders
  Future<Either<Failure, GenderResponse>> getGenders() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.gendersPath,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
          url: url,
          headers: _authHeaders
            ..addAll({"Authorization": "Bearer ${accessToken!}"}));

      final body = GenderResponse.fromMap(jsonDecode(response.body));
      return Right(body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }
}
