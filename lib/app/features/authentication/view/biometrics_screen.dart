import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/app_colors.dart';
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
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(
                text: 'Biometrics',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.065,
              ),

              
              const VerticalSpace(
                size: 15,
              ),

              // fingerprint/faceId prompt
              AppText(
                text: '''Use your fingerprint/face ID to unlock your 
                                    Floatr account''',
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 150,
              ),

              SvgPicture.asset('assets/images/biometric.svg'),

              const VerticalSpace(
                size: 150,
              ),

              // enable button
              GeneralButton(
                onPressed: () {},
                child: const Text('Enable'),
              ),

              const VerticalSpace(
                size: 30,
              ),

              // not right now
              AppText(
                text: 'Not right now',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
                size: context.widthPx * 0.039,
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
