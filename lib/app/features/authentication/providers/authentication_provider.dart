import 'dart:io';

import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/reset_password_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_bvn_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_phone_params.dart';
import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/app/features/authentication/data/repositories/biometric_repository.dart';
import 'package:floatr/app/features/profile/view/screens/edit_profile.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:floatr/core/misc/dependency_injectors.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/route/navigation_service.dart';
import '../../profile/data/model/user_helper.dart';
import '../data/model/params/register_params.dart';

class AuthenticationProvider extends BaseProvider {
  final AuthenticationRepository authenticationRepository;
  final BiometricRepository biometricRepository;
  AuthenticationProvider(
      {required this.authenticationRepository,
      required this.biometricRepository});

  final NavigationService _navigationService = di<NavigationService>();

  LoginParams? _loginParams;

  LoginParams? get loginParams => _loginParams;

  RegisterParams? _registerParams;

  RegisterParams? get registerParams => _registerParams;

  VerifyPhoneParams? _verifyPhoneParams;

  VerifyPhoneParams? get verifyPhoneParams => _verifyPhoneParams;

  VerifyBVNParams? _verifyBVNParams;

  VerifyBVNParams? get verifyBVNParams => _verifyBVNParams;

  UserResponse? _user;

  UserResponse? get user => _user;

  ResetPasswordParams? _resetPasswordParams;

  ResetPasswordParams? get resetPasswordParams => _resetPasswordParams;

  File? _imagefile;

  File? get imagefile => _imagefile;

  bool? _tempCompletionStatus;

  bool? get tempCompletionStatus => _tempCompletionStatus;

  String? _transactionPin;

  String? get transactionPin => _transactionPin;

  bool _isBiometricLoginEnabled() =>
      authenticationRepository.isBiometricLoginEnabled;

  bool get isLoggedIn => _isLoggedIn();

  bool get isBiometricLoginEnabled => _isBiometricLoginEnabled();

  setBiometricLogin(bool isEnabled) => authenticationRepository.setBiometricLogin(isEnabled);


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

  updateImage(File file) {
    _imagefile = file;
    notifyListeners();
  }

  updateUser(UserResponse userResponse) {
    _user = userResponse;
    notifyListeners();
  }

  updateTempCompletion(bool tempCompletionStatus) {
    _tempCompletionStatus = tempCompletionStatus;
    notifyListeners();
  }

  updateTransactionPin(String transactionPin) {
    _transactionPin = transactionPin;
    notifyListeners();
  }

  updateResetPasswordParams(ResetPasswordParams resetPasswordParams) {
    _resetPasswordParams = resetPasswordParams;
    notifyListeners();
  }

  Future<bool> canAuthenticate() => biometricRepository.canAuthenticate();

  // Future<void> didAuthenticate([bool performBiometricLogin = false]) async {
  //   // updateLoadingState(LoadingState.busy);
  //   canAuthenticate().then((canAuthenticate) {
  //     if (canAuthenticate) {
  //       biometricRepository.didAuthenticate().then((didAuthenticate) async {
  //         performBiometricLogin ? await biometricLogin() : () {};
  //       });
  //     }
  //   });
  // }

  Future<void> biometricLogin() async {
    var response = await authenticationRepository.biometricLogin();

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A login error occured!');
      // trigger error on ui
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) async {
      await getUser();
      _navigationService.navigateReplacementTo(RouteName.navbar);
    });
  }

  Future<void> initiateLogin(BuildContext context) async {
    updateLoadingState(LoadingState.busy);

    var response = await authenticationRepository.login(_loginParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A login error occured!');
      // trigger error on ui
      AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) async {
      // updateLoadingState(LoadingState.loaded);
      await getUser();

      if (!_user!.isPhoneVerified!) {
        _navigationService.navigateTo(RouteName.verifyOTP);
      } else if (!_user!.isBvnVerified!) {
        _navigationService.navigateTo(RouteName.verifyBVN);
      } else if (!user!.isPhotoVerified!) {
        _navigationService.navigateTo(RouteName.takeSelfie);
      } else {
        _navigationService.pushAndRemoveUntil(RouteName.navbar);
      }
    });
  }

  Future<void> initiateRegistration(BuildContext context) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.register(_registerParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A registration error occured!');
      // trigger error on ui
      AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateTo(RouteName.verifyOTP);
    });
  }

  bool _isLoggedIn() {
    if (_user != null) {
      if (!_user!.isPhoneVerified! ||
          !_user!.isBvnVerified! ||
          !_user!.isPhotoVerified!) {
        return false;
      }
    }
    return authenticationRepository.isLoggedIn;
  }

  Future<void> initiateVerifyPhone(BuildContext context) async {
    updateLoadingState(LoadingState.busy);
    var response =
        await authenticationRepository.verifyPhone(_verifyPhoneParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Phone verification failed!');
      // trigger error on ui
      AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateReplacementTo(RouteName.verifyBVN);
    });
  }

  void logout() {
    authenticationRepository.logout();
    _navigationService.pushAndRemoveUntil(RouteName.postOnboarding);
  }

  Future<void> initiateVerifyBVN(BuildContext context) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.verifyBVN(_verifyBVNParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'BVN verification failed!');
      AppSnackBar.showErrorSnackBar(context, errorMsg);
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.navigateReplacementTo(RouteName.takeSelfie);
    });
  }

  Future<void> resendOTP(BuildContext context) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.beginPhoneVerification();

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Resend otp failed');
      AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
    });
  }

  Future<void> getUser() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.getUser();
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Failed to get user');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateUser(onSuccess);
    });
  }

  Future<void> createPin() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.createPin(_transactionPin!);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Pin creation failed!');
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
      // trigger error on ui
    }, (onSuccess) {
      getUser();
      updateLoadingState(LoadingState.loaded);
    });
  }

  Future<void> uploadimage(BuildContext context, ImageType imageType,
      [DocumentType documentType = DocumentType.driverLicense]) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.uploadPicture(
        _imagefile!, imageType, documentType);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'File upload failed!');
      AppSnackBar.showErrorSnackBar(context, errorMsg);
      // trigger error on ui
    }, (onSuccess) {
      getUser();
      updateLoadingState(LoadingState.loaded);
      Fluttertoast.showToast(
          backgroundColor: Colors.blue,
          msg: imageType == ImageType.selfie
              ? 'Selfie upload successful'
              : 'Document upload successful');

      if (imageType == ImageType.selfie) {
        _navigationService.pushAndRemoveUntil(RouteName.confirmDetails);
      } else {
        !UserHelper(user: user!).isAddressComplete
            ? _navigationService.navigateReplacementTo(RouteName.editProfile,
                arguments: EditProfileArguments(
                    editProfileView: EditProfile.residentialAddress))
            : _navigationService.pushAndRemoveUntil(RouteName.navbar);
      }
    });
  }

  Future<void> forgotPassword() async {
    updateLoadingState(LoadingState.busy);
    var response =
        await authenticationRepository.forgotPassword(_resetPasswordParams!);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(
          onError.message ?? 'Initiating forgot password failed');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
    });
  }

  Future<void> verifyForgotPasswordToken() async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository
        .verifyForgotPasswordToken(_resetPasswordParams!);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Verifying token failed');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
    });
  }

  Future<void> resetPassword() async {
    updateLoadingState(LoadingState.busy);
    var response =
        await authenticationRepository.resetPassword(_resetPasswordParams!);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Password reset failed');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
    });
  }
}
