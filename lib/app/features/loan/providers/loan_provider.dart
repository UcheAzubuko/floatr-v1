import 'dart:developer';

import 'package:floatr/app/features/loan/data/repositories/loans_repository.dart';
import 'package:floatr/app/features/loan/model/params/verify_bank_params.dart';
import 'package:floatr/app/features/loan/model/responses/loans_response.dart';
import 'package:floatr/app/features/loan/model/responses/verify_bank_response.dart';
import 'package:floatr/core/providers/base_provider.dart';

import '../model/responses/banks_response.dart';
import '../model/responses/my_banks_response.dart';

class LoanProvider extends BaseProvider {
  final LoansRepository _loansRepository;
  LoanProvider({required LoansRepository loansRepository})
      : _loansRepository = loansRepository;

  LoadingState _loadingState = LoadingState.idle;
  String _errorMsg = 'An unknown error occured';

  LoansResponse? _loansResponse;

  LoansResponse? get loansResponse => _loansResponse;

  BanksResponse? _banksResponse;

  BanksResponse? get banksResponse => _banksResponse;

  MyBanksResponse? _myBanksResponse;

  MyBanksResponse? get myBanksResponse => _myBanksResponse;

  BankParams? _bankParams;

  BankParams? get bankParams => _bankParams;

  AddBankParams? _addBankParams;

  AddBankParams? get addBankParams => _addBankParams;

  VerifyBankResponse? _verifyBankResponse;

  VerifyBankResponse? get verifyBankResponse => _verifyBankResponse;

  @override
  LoadingState get loadingState => _loadingState;

  @override
  String get errorMsg => _errorMsg;

  @override
  updateLoadingState(LoadingState loadingState) {
    _loadingState = loadingState;
    notifyListeners();
  }

  @override
  updateErrorMsgState(String errorMsg) {
    _errorMsg = errorMsg;
    notifyListeners();
  }

  updateFeaturedLoans(LoansResponse loansResponse) {
    _loansResponse = loansResponse;
    notifyListeners();
  }

  updateBanks(BanksResponse banksResponse) {
    _banksResponse = banksResponse;
    notifyListeners();
  }

  updateMyBanks(MyBanksResponse myBanksResponse) {
    _myBanksResponse = myBanksResponse;
    notifyListeners();
  }

  updateBankParams(BankParams bankParams) {
    _bankParams = bankParams;
    notifyListeners();
  }

  updateAddBankParams(AddBankParams addBankParams) {
    _addBankParams = addBankParams;
    notifyListeners();
  }

  updateAccount(VerifyBankResponse verifyBankResponse) {
    _verifyBankResponse = verifyBankResponse;
    notifyListeners();
  }

  Future<void> getFeaturedLoans() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.getLoans();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get loans');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateFeaturedLoans(onSuccess);
    });
  }

  Future<void> getBanks() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.getBanks();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get Banks');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateBanks(onSuccess);
    });
  }

  Future<void> getMyBanks() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.getMyBanks();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get Banks');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateMyBanks(onSuccess);
    });
  }

  Future<void> addBank() async {
    updateLoadingState(LoadingState.busy);

    final repsonse =
        await _loansRepository.addBank(addBankParams!..processor = 'monnify');

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not add bank');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      log("Added bank successfully");
    });
  }

  Future<void> verifyAccount() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository
        .verifyAccount(bankParams!..processor = 'monnify');

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not Verify bank');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateAccount(onSuccess);
    });
  }
}
