import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/data/data_source/remote/api_configs.dart';
import 'package:floatr/core/providers/biometric_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';

class BiometricsScreen extends StatelessWidget {
  const BiometricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Consumer<BiometricProvider>(
          builder: (context, biometricProvider, _) {
            final isFingerPrint =
                biometricProvider.biometricType == BiometricType.fingerprint;
            return Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppText(
                    text: isFingerPrint ? 'Fingerprint' : 'Face ID',
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w900,
                    size: context.widthPx * 0.065,
                  ),

                  const VerticalSpace(
                    size: 15,
                  ),

                  // fingerprint/faceId prompt
                  AppText(
                    text:
                        '''Get easy access to your account \nby unlocking with your ${isFingerPrint ? 'fingerprint' : 'face ID'}.''',
                    color: AppColors.grey,
                    fontWeight: FontWeight.w600,
                    size: context.widthPx * 0.031,
                  ),

                  const VerticalSpace(
                    size: 250,
                  ),

                  // preferred biometric icon
                  SvgPicture.asset(isFingerPrint
                      ? SvgImages.biometricFingerprint
                      : SvgImages.biometricFaceId),

                  const VerticalSpace(
                    size: 150,
                  ),

                  // enable button
                  //  button
                  GeneralButton(
                      onPressed: () =>
                          _handleBiometricAuthentication(biometricProvider),
                      child: const Text('SET UP BIOMETRICS')),

                  const VerticalSpace(
                    size: 30,
                  ),

                  // remind me later
                  TextButton(
                    onPressed: () => di<NavigationService>()
                        .pushAndRemoveUntil(RouteName.navbar),
                    child: const Text(
                      'Remind me later',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }

  _handleBiometricAuthentication(BiometricProvider biometricProvider) {
    biometricProvider.didAuthenticate(() {
      di<NavigationService>().pushAndRemoveUntil(RouteName.navbar);
      di<SharedPreferences>().setBool(StorageKeys.biometricStatusKey, true);
    }, 'Enable biometric').then((_) {

    });
  }
}
