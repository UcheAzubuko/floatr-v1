import 'dart:io';

import 'package:floatr/app/features/authentication/data/model/params/login_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_bvn_params.dart';
import 'package:floatr/app/features/authentication/data/model/params/verify_phone_params.dart';
import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
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

  VerifyPhoneParams? _verifyPhoneParams;

  VerifyPhoneParams? get verifyPhoneParams => _verifyPhoneParams;

  VerifyBVNParams? _verifyBVNParams;

  VerifyBVNParams? get verifyBVNParams => _verifyBVNParams;

  UserResponse? _user;

  UserResponse? get user => _user;

  File? _imagefile;

  File? get imagefile => _imagefile;

  bool? _tempCompletionStatus;

  bool? get tempCompletionStatus => _tempCompletionStatus;

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

  Future<void> initiateLogin(BuildContext context) async {
    updateLoadingState(LoadingState.busy);

    var response = await authenticationRepository.login(_loginParams!);

    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'A login error occured!');
      // trigger error on ui
      AppSnackBar.showErrorSnackBar(context, errorMsg);
    }, (onSuccess) async {
      await getUser();
      
      if (!_user!.isPhoneVerified!) {
        _navigationService.navigateTo(RouteName.verifyOTP);
      } else if (!_user!.isBvnVerified!) {
        _navigationService.navigateTo(RouteName.verifyBVN);
      } else if (!user!.isPhotoVerified!) {
        _navigationService.navigateTo(RouteName.takeSelfie);
      } else {
        _navigationService.navigateTo(RouteName.navbar);
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

  Future<void> getUser({bool? shouldMaskUser}) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.getUser(shouldMaskUser: shouldMaskUser ?? false);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'Failed to get user');
      // AppSnackBar.showErrorSnackBar(context, errorMsg);
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateUser(onSuccess);
    });
  }

  Future<void> uploadimage(BuildContext context) async {
    updateLoadingState(LoadingState.busy);
    var response = await authenticationRepository.uploadPicture(_imagefile!);
    response.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? 'File upload failed!');
      AppSnackBar.showErrorSnackBar(context, errorMsg);
      // trigger error on ui
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      _navigationService.pushAndRemoveUntil(RouteName.confirmDetails);
    });
  }
}
