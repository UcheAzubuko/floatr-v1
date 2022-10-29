import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final NavigationService navigationService = di<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // verify screen
            AppText(
              text: 'Verify Screen',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            AppText(
              text: '''Please enter the code that was sent to:     
+2348147990002''',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(
              size: 60,
            ),

            OTPTextField(
              length: 4,
              width: context.widthPx,
              fieldStyle: FieldStyle.box,
              fieldWidth: context.widthPx * 0.18,
              style: TextStyle(fontSize: context.widthPx * 0.12),
              outlineBorderRadius: 15,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: AppColors.grey.withOpacity(0.1),
                enabledBorderColor: Colors.transparent,
              ),
            ),

            const VerticalSpace(
              size: 60,
            ),

            AppText(
              text: 'Didn\'t get the code? Resend Code',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.031,
            ),

            const Spacer(),

            GeneralButton(
              onPressed: () =>
                  navigationService.navigateTo(RouteName.verifyBVN),
              buttonTextColor: Colors.white,
              child: const Text(
                'Verify Phone',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
