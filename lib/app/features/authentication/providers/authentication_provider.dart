import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/core/misc/dependency_injectors.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';

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

  updateLoginParams(LoginParams params) {
    _loginParams = params;
    notifyListeners();
  }

  updateRegisterParams(RegisterParams params) {
    _registerParams = params;
    notifyListeners();
  }

  Future<void> initiateLogin() async {
    updateLoadingState(LoadingState.busy);

    var response = await authenticationRepository.login(_loginParams!);

    response.fold((l) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(l.message ?? 'A login error occured!');
      // trigger error on ui
    }, (r) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.createPin);
    });
  }

  Future<void> initiateRegistration() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.register(_registerParams!);

    response.fold((l) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(l.message ?? 'A registration error occured!');
      // trigger error on ui
    }, (r) {
      updateLoadingState(LoadingState.loaded);
    });
  }
}
