import 'package:floatr/core/providers/base_provider.dart';
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

  BiometricType? _biometricType;

  BiometricType? get biometricType => _biometricType;

  bool? _isUserAuthenticated;

  bool? get isUserAuthenticated => _isUserAuthenticated;

  updateBiometricType(BiometricType? biometricType) {
    _biometricType = biometricType;
    notifyListeners();
  }

  updateDidAuthenticate(bool didAuthenticate) {
    _isUserAuthenticated = didAuthenticate;
    notifyListeners();
  }

  Future<void> getBiometricType() async {
    final response = await _biometricRepository.getBiometricType();

    response.fold((onError) {
      updateErrorMsgState(onError.message!);
      updateBiometricType(null);
    }, (onSuccess) {
      updateBiometricType(onSuccess);
    });
  }

  /// onSuccessCallback calls only when fingerprint was successful
  Future<void> didAuthenticate(Function? onSuccessCallback,
      [String? message]) async {
    final response = await _biometricRepository.didAuthenticate(message);

    response.fold((onError) {
      updateErrorMsgState(onError.message!);
      updateDidAuthenticate(false);
    }, (onSuccess) {
      if (onSuccess) {
        updateDidAuthenticate(onSuccess);
        onSuccessCallback!();
      }
    });
  }
}
