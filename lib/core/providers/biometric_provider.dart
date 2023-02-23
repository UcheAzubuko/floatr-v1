import 'package:floatr/core/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../app/features/authentication/data/repositories/biometric_repository.dart';

class BiometricProvider extends BaseProvider {
  final BiometricRepository _biometricRepository;
  BiometricProvider({required BiometricRepository biometricRepository})
      : _biometricRepository = biometricRepository;

  LoadingState _loadingState = LoadingState.idle;
  String _errorMsg = 'An unknown error occured';

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

  BiometricType? get biometricType => _biometricType.value;

  final ValueNotifier<BiometricType?> _biometricType =
      ValueNotifier<BiometricType?>(null);

  Future<void> getBiometricType() async {
    final response = await _biometricRepository.getBiometricType();

    response.fold((onError) {
      updateErrorMsgState(onError.message!);
    }, (onSuccess) {
      _biometricType.value = onSuccess;
    });
  }
}
