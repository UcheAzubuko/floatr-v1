import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/register_params.dart';
import 'package:floatr/core/data/data_source/remote/api_configs.dart';
import 'package:floatr/core/data/services/api_service.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:floatr/core/errors/failure.dart';

class AuthenticationRepository {
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
      return Right(body["access_token"]); // grab access_token
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
      return Right(body["access_token"]);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code as String, message: _.message));
    }
  }
}
