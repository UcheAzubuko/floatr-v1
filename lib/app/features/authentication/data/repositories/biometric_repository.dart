import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
// import 'package:local_auth/error_codes.dart' as auth_error;

import '../../../../../core/errors/failure.dart';

class BiometricRepository {
  const BiometricRepository({required LocalAuthentication localAuthentication})
      : _localAuthentication = localAuthentication;
  final LocalAuthentication _localAuthentication;

  // Future<bool> canAuthenticateWithBiometrics() async =>
  //     await _localAuthentication.canCheckBiometrics;

  Future<bool> canAuthenticate() async =>
      await _localAuthentication.canCheckBiometrics ||
      await _localAuthentication.isDeviceSupported();

  Future<Either<Failure, bool>> didAuthenticate() async {
    try {
      final bool didAuthenticate = await _localAuthentication.authenticate(
          localizedReason: 'Please authenticate to proceed.',
          options: const AuthenticationOptions(useErrorDialogs: false, biometricOnly: true, stickyAuth: true,));
      return Right(didAuthenticate);
    } on PlatformException catch (e) {
      return Left(LocalAuthFailure(code: e.code, message: e.message));
    }
  }
}
