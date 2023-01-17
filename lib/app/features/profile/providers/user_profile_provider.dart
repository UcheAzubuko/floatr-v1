import 'package:floatr/app/features/profile/data/model/params/employer_information_params.dart';
import 'package:floatr/app/features/profile/data/model/params/next_of_kin_params.dart';
import 'package:floatr/app/features/profile/data/model/params/residential_address_params.dart';
import 'package:floatr/app/features/profile/data/model/params/user_profile_params.dart';
import 'package:floatr/app/features/profile/data/repositories/profile_repository.dart';
import 'package:floatr/core/providers/base_provider.dart';

class UserProfileProvider extends BaseProvider {
  final ProfileRepository _profileRepository;

  UserProfileProvider({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  EmployerInformationParams? _employerInformationParams;

  EmployerInformationParams? get employerInformationParams =>
      _employerInformationParams;

  NextOfKinParams? _nextOfKinParams;

  NextOfKinParams? get nextOfKinParams => _nextOfKinParams;

  UserProfileParams? _userProfileParams;

  UserProfileParams? get userProfileParams => _userProfileParams;

  ResidentialAddressParams? _residentialAddressParams;

  ResidentialAddressParams? get residentialAddressParams =>
      _residentialAddressParams;

  updateEmployerInformation(EmployerInformationParams params) {
    _employerInformationParams = params;
    notifyListeners();
  }

  updateNextOfKinParams(NextOfKinParams params) {
    _nextOfKinParams = params;
    notifyListeners();
  }

  updateUserProfileParams(UserProfileParams params) {
    _userProfileParams = params;
    notifyListeners();
  }

  updateResidentialParams(ResidentialAddressParams params) {
    _residentialAddressParams = params;
    notifyListeners();
  }

  Future<void> updateResidentialAddress() async {
    updateLoadingState(LoadingState.busy);
    var response = await _profileRepository
        .updateResidentialAddress(_residentialAddressParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'Update residential address failed!');
      // trigger error on ui
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      // _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }

  Future<void> updateUserProfiile() async {
    updateLoadingState(LoadingState.busy);
    var response =
        await _profileRepository.updateUserProfile(_userProfileParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'User profile update failed!');
      // trigger error on ui
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      // _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }

  Future<void> updateNextOfKin() async {
    updateLoadingState(LoadingState.busy);
    var response = await _profileRepository.updateNextOfKin(_nextOfKinParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Update next of kin failed!');
      // trigger error on ui
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      // _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }

  Future<void> updateEmploymentInformation() async {
    updateLoadingState(LoadingState.busy);
    var response = await _profileRepository
        .updateEmployerInformation(employerInformationParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'Update employment information failed!');
      // trigger error on ui
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      // _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }
}
