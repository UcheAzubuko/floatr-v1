import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/dashboard/data/model/response/activities_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/data_source/remote/api_configs.dart';
import '../../../../../core/data/services/api_service.dart';
import '../../../../../core/errors/exception.dart';
import '../../../../../core/errors/failure.dart';

class ActivitiesRepository {
  final SharedPreferences _sharedPreferences;
  final APIService _apiService;

  ActivitiesRepository(
      {required SharedPreferences sharedPreferences,
      required APIService apiService})
      : _sharedPreferences = sharedPreferences,
        _apiService = apiService;

  /// Headers
  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<Either<Failure, ActivitiesResponse>> getMyActivies() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.activities,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
        url: url,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      print(response.body);
      return Right(ActivitiesResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      print(_.message);
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }
}
