import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/providers/biometric_provider.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';

class BiometricScreen extends StatelessWidget {
  const BiometricScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(
      child: Consumer<BiometricProvider>(
        builder: (context, biometricProvider, _) {
          final isFingerPrint =
              biometricProvider.biometricType == BiometricType.fingerprint;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // preferred biometric
              Text(
                isFingerPrint ? 'Fingerprint' : 'Face ID',
                style: TextStyles.largeTextPrimary,
              ),

              // prompt
              Text(
                  '''Get easy access to your account \nby unlocking with your ${isFingerPrint ? 'fingerprint' : 'face ID'}.'''),

              // preferred biometric icon
              SvgPicture.asset(isFingerPrint
                  ? SvgImages.biometricFingerprint
                  : SvgImages.biometricFaceId),

              //  button
              GeneralButton(
                  onPressed: () {}, child: const Text('SET UP BIOMETRICS')),

              // remind me later
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Remind me later',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
