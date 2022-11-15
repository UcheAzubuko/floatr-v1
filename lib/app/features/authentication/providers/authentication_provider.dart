import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/core/providers/base_provider.dart';

import '../data/model/params/register_params.dart';

class AuthenticationProvider extends BaseProvider {
  final AuthenticationRepository authenticationRepository;
  AuthenticationProvider({required this.authenticationRepository});

  LoginParams? _loginParams;

  LoginParams? get loginParams => _loginParams;

  RegisterParams? _registerParams;

  RegisterParams? get registerParams => _registerParams;

  updateLoginParams(LoginParams params) {
    _loginParams = loginParams;
    notifyListeners();
  }

  updateRegisterParams(RegisterParams params) {
    _registerParams = registerParams;
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
