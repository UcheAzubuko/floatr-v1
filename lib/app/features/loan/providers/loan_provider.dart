import 'package:floatr/app/features/loan/data/repositories/loans_repository.dart';
import 'package:floatr/app/features/loan/model/responses/loans_response.dart';
import 'package:floatr/core/providers/base_provider.dart';

import '../model/responses/banks_response.dart';

class LoanProvider extends BaseProvider {
  final LoansRepository _loansRepository;
  LoanProvider({required LoansRepository loansRepository})
      : _loansRepository = loansRepository;

  LoadingState _loadingState = LoadingState.idle;

  LoansResponse? _loansResponse;

  LoansResponse? get loansResponse => _loansResponse;

  BanksResponse? _banksResponse;

  BanksResponse? get banksResponse => _banksResponse;

  @override
  LoadingState get loadingState => _loadingState;

  @override
  updateLoadingState(LoadingState loadingState) {
    _loadingState = loadingState;
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
}
