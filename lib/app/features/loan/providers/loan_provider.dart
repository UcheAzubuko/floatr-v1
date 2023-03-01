import 'dart:developer';

import 'package:floatr/app/features/loan/data/repositories/loans_repository.dart';
import 'package:floatr/app/features/loan/model/params/request_loan_params.dart';
import 'package:floatr/app/features/loan/model/params/verify_bank_params.dart';
import 'package:floatr/app/features/loan/model/responses/card_response.dart';
import 'package:floatr/app/features/loan/model/responses/loans_response.dart';
import 'package:floatr/app/features/loan/model/responses/verify_bank_response.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:flutter/material.dart';

import '../model/params/add_card_params.dart';
import '../model/responses/banks_response.dart' as bank;
import '../model/responses/my_banks_response.dart';

class LoanProvider extends BaseProvider {
  final LoansRepository _loansRepository;
  LoanProvider({required LoansRepository loansRepository})
      : _loansRepository = loansRepository;

  LoadingState _loadingState = LoadingState.idle;
  String _errorMsg = 'An unknown error occured';

  LoansResponse? get loansResponse => _loansResponse.value;

  final ValueNotifier<LoansResponse?> _loansResponse =
      ValueNotifier<LoansResponse?>(LoansResponse(loans: List<Loan>.empty()));

  final ValueNotifier<bank.BanksResponse?> _banksResponse =
      ValueNotifier<bank.BanksResponse?>(
          bank.BanksResponse(banks: List<bank.Bank>.empty()));

  bank.BanksResponse? get banksResponse => _banksResponse.value;

  final ValueNotifier<MyBanksResponse?> _myBanksResponse =
      ValueNotifier<MyBanksResponse?>(
          MyBanksResponse(mybanks: List<MyBank>.empty()));

  MyBanksResponse? get myBanksResponse => _myBanksResponse.value;

  BankParams? _bankParams;

  BankParams? get bankParams => _bankParams;

  AddBankParams? _addBankParams;

  AddBankParams? get addBankParams => _addBankParams;

  AddCardParams? _addCardParams;

  AddCardParams? get addCardParams => _addCardParams;

  RequestLoanParams? _requestLoanParams;

  RequestLoanParams? get requestLoanParams => _requestLoanParams;

  final ValueNotifier<VerifyBankResponse?> _verifyBankResponse =
      ValueNotifier<VerifyBankResponse?>(null);

  VerifyBankResponse? get verifyBankResponse => _verifyBankResponse.value;

  final ValueNotifier<CardResponse?> _myCardsResponse =
      ValueNotifier<CardResponse?>(null);

  CardResponse? get myCardsResponse => _myCardsResponse.value;

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

  // updateFeaturedLoans(LoansResponse loansResponse) {
  //   _loansResponse = loansResponse;
  //   notifyListeners();
  // }

  // updateBanks(BanksResponse banksResponse) {
  //   _banksResponse = banksResponse;
  //   notifyListeners();
  // }

  // updateMyBanks(MyBanksResponse myBanksResponse) {
  //   _myBanksResponse = myBanksResponse;
  //   notifyListeners();
  // }

  updateBankParams(BankParams bankParams) {
    _bankParams = bankParams;
    notifyListeners();
  }

  updateAddBankParams(AddBankParams addBankParams) {
    _addBankParams = addBankParams;
    notifyListeners();
  }

  updateAddCardParams(AddCardParams addCardParams) {
    _addCardParams = addCardParams;
    notifyListeners();
  }

  updateRequestLoanParams(RequestLoanParams requestLoanParams) {
    _requestLoanParams = requestLoanParams;
    notifyListeners();
  }

  // updateAccount(VerifyBankResponse verifyBankResponse) {
  //   _verifyBankResponse = verifyBankResponse;
  //   notifyListeners();
  // }

  Future<void> getFeaturedLoans() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.getLoans();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get loans');
    }, (onSuccess) {
      _loansResponse.value = onSuccess;
      updateLoadingState(LoadingState.loaded);
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
      _banksResponse.value = onSuccess;
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
      _myBanksResponse.value = onSuccess;
    });
  }

  Future<void> getMyCards() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.getMyCards();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get Cards');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _myCardsResponse.value = onSuccess;
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
      getMyBanks();
      log("Added bank successfully");
    });
  }

  Future<void> addCard() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.addCard(_addCardParams!);

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not add card');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      log("Added Card successfully");
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
      _verifyBankResponse.value = onSuccess;
    });
  }

  Future<void> requestLoan() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _loansRepository.requestLoan(_requestLoanParams!);

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not Verify bank');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
    });
  }
}
