import 'package:floatr/app/features/profile/data/model/responses/country_repsonse.dart';
import 'package:floatr/app/features/profile/data/model/responses/gender_response.dart';
import 'package:floatr/app/features/profile/data/model/responses/marital_status_response.dart';
import 'package:floatr/app/features/profile/data/model/responses/state_repsonse.dart';
import 'package:floatr/app/features/profile/data/repositories/user_resources_repository.dart';

import '../../../../core/providers/base_provider.dart';

class UserResourcesProvider extends BaseProvider {
  final UserResourcesRepository _userResourcesRepository;
  UserResourcesProvider(
      {required UserResourcesRepository userResourcesRepository})
      : _userResourcesRepository = userResourcesRepository;

  GenderResponse? _genderResponse;
  StateResponse? _stateResponse;
  MaritalStatusResponse? _maritalStatusResponse;
  CountryResponse? _countryResponse;

  GenderResponse? get genderResponse => _genderResponse;
  StateResponse? get stateResponse => _stateResponse;
  MaritalStatusResponse? get maritalStatusResponse => _maritalStatusResponse;
  CountryResponse? get countryRepsonse => _countryResponse;

  updateGenderResponse(GenderResponse genderResponse) {
    _genderResponse = genderResponse;
    notifyListeners();
  }

  updateStateResponse(StateResponse? stateResponse) {
    _stateResponse = stateResponse;
    notifyListeners();
  }

  updateMaritalStatus(MaritalStatusResponse maritalStatusResponse) {
    _maritalStatusResponse = maritalStatusResponse;
    notifyListeners();
  }

  updateCountryResponse(CountryResponse countryResponse) {
    _countryResponse = countryResponse;
    notifyListeners();
  }

  Future<void> getCountries() async {
    updateLoadingState(LoadingState.busy);

    var response = await _userResourcesRepository.getCountries();

    updateStateResponse(null);
    
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      
      updateErrorMsgState(
          onError.message ?? 'An error occured getting countries!');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateCountryResponse(onSuccess);
    });
  }

  Future<void> getMaritalStatuses() async {
    updateLoadingState(LoadingState.busy);

    var response = await _userResourcesRepository.getMaritalStatus();

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'An error occured getting marital statuses!');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateMaritalStatus(onSuccess);
    });
  }

  Future<void> getStates(String countryCode) async {
    updateLoadingState(LoadingState.busy);

    var response = await _userResourcesRepository.getStates(countryCode);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'An error occured getting states!');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateStateResponse(onSuccess);
    });
  }

  Future<void> getGenders() async {
    updateLoadingState(LoadingState.busy);

    var response = await _userResourcesRepository.getGenders();

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'An error occured getting genders!');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateGenderResponse(onSuccess);
    });
  }
}
