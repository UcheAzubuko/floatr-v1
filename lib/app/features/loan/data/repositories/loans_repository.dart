import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:floatr/app/features/loan/model/params/request_loan_params.dart';
import 'package:floatr/app/features/loan/model/params/verify_bank_params.dart';
import 'package:floatr/app/features/loan/model/responses/card_response.dart';
import 'package:floatr/app/features/loan/model/responses/loans_response.dart';
import 'package:floatr/app/features/loan/model/responses/my_banks_response.dart';
import 'package:floatr/app/features/loan/model/responses/verify_bank_response.dart';
import 'package:floatr/core/errors/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/data_source/remote/api_configs.dart';
import '../../../../../core/data/services/api_service.dart';
import '../../../../../core/errors/failure.dart';
import '../../model/params/add_card_params.dart';
import '../../model/responses/banks_response.dart';

class LoansRepository {
  final SharedPreferences _sharedPreferences;
  final APIService _apiService;

  LoansRepository(
      {required SharedPreferences sharedPreferences,
      required APIService apiService})
      : _sharedPreferences = sharedPreferences,
        _apiService = apiService;

  /// Headers
  final Map<String, String> _headers = {
    "Accept": "application/json",
    "Content-Type": "application/json"
  };

  Future<Either<Failure, LoansResponse>> getLoans() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.loans,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
        url: url,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(LoansResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, BanksResponse>> getBanks() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.banks,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.get(
        url: url,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(BanksResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> addBank(AddBankParams addBankParams) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.userBanks,
    );

    final postBody = addBankParams.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: postBody,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      log(response.body);
      return const Right('Success');
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, MyBanksResponse>> getMyBanks() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.userBanks,
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);

      final response = await _apiService.get(
        url: url,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(MyBanksResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> addCard(AddCardParams params) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyCard,
    );

    final body = params.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);

      final response = await _apiService.post(
          url: url,
          headers: _headers
            ..addAll(
              {"Authorization": "Bearer ${accessToken!}"},
            ),
          body: body);

      return Right(response.body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, CardResponse>> getMyCards() async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.userCards(),
    );

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);

      final response = await _apiService.get(
        url: url,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(CardResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> makeCardDefault(
      {required String cardUniqueId, required bool isDefault}) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.userCards(cardUniqueId),
    );

    final Map<String, dynamic> body = {'isDefault': true};

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);

      final response = await _apiService.patch(
        url: url,
        body: body,
        headers: _headers
          ..addAll({"Authorization": "Bearer ${accessToken!}"})
          ..remove("Content-Type"),
      );
      return Right(response.body);
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, VerifyBankResponse>> verifyAccount(
      BankParams bankParams) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.verifyAccount,
    );

    final params = bankParams.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: params,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(VerifyBankResponse.fromJson(jsonDecode(response.body)));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }

  Future<Either<Failure, String>> requestLoan(
      RequestLoanParams requestLoanParams) async {
    final url = Uri.https(
      APIConfigs.baseUrl,
      APIConfigs.userLoans,
    );

    final params = requestLoanParams.toMap();

    try {
      String? accessToken =
          _sharedPreferences.getString(StorageKeys.accessTokenKey);
      final response = await _apiService.post(
        url: url,
        body: params,
        headers: _headers..addAll({"Authorization": "Bearer ${accessToken!}"}),
      );
      return Right(jsonDecode(response.body));
    } on ServerException catch (_) {
      return Left(ServerFailure(code: _.code.toString(), message: _.message));
    }
  }
}
