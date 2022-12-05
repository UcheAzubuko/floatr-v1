import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_bvn_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_phone_params.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/core/misc/dependency_injectors.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/route_names.dart';

import '../../../../core/route/navigation_service.dart';
import '../data/model/params/register_params.dart';

class AuthenticationProvider extends BaseProvider {
  final AuthenticationRepository authenticationRepository;
  AuthenticationProvider({required this.authenticationRepository});

  final NavigationService _navigationService = di<NavigationService>();

  LoginParams? _loginParams;

  LoginParams? get loginParams => _loginParams;

  RegisterParams? _registerParams;

  RegisterParams? get registerParams => _registerParams;

  VerifyPhoneParams? _verifyPhoneParams;

  VerifyPhoneParams? get verifyPhoneParams => _verifyPhoneParams;

  VerifyBVNParams? _verifyBVNParams;

  VerifyBVNParams? get verifyBVNParams => _verifyBVNParams;

  updateLoginParams(LoginParams params) {
    _loginParams = params;
    notifyListeners();
  }

  updateRegisterParams(RegisterParams params) {
    _registerParams = params;
    notifyListeners();
  }

  updateVerifyBVNParams(VerifyBVNParams params) {
    _verifyBVNParams = params;
    notifyListeners();
  }

  updateVerifyPhoneParams(VerifyPhoneParams params) {
    _verifyPhoneParams = params;
    notifyListeners();
  }

  Future<void> initiateLogin() async {
    updateLoadingState(LoadingState.busy);

    var response = await authenticationRepository.login(_loginParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A login error occured!');
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.createPin);
    });
  }

  Future<void> initiateRegistration() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.register(_registerParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A registration error occured!');
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }

  Future<void> initiateVerifyPhone() async {
    updateLoadingState(LoadingState.busy);
    var response =
        await authenticationRepository.verifyPhone(_verifyPhoneParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Phone verification failed!');

      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.verifyBVN);
    });
  }

  Future<void> initiateVerifyBVN() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.verifyBVN(_verifyBVNParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'BVN verification failed!');
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.takeSelfie);
    });
  }
}
