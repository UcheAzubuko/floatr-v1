import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';

class CreatePinScreen extends StatelessWidget {
  const CreatePinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // verify screen
            AppText(
              text: 'Create 5-Digit PIN',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            AppText(
              text: '''Please enter a 5-digit PIN code to protect your 
Floatr account''',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(
              size: 60,
            ),

            // pin field

            // OTPTextField(
            //   length: 4,
            //   width: context.widthPx,
            //   fieldStyle: FieldStyle.box,
            //   fieldWidth: context.widthPx * 0.18,
            //   style: TextStyle(fontSize: context.widthPx * 0.12),
            //   outlineBorderRadius: 15,
            //   inputFormatter: [
            //     FilteringTextInputFormatter.digitsOnly,
            //   ],
            //   otpFieldStyle: OtpFieldStyle(
            //     backgroundColor: AppColors.grey.withOpacity(0.1),
            //     enabledBorderColor: Colors.transparent,
            //   ),
            // ),

            const Spacer(),

            GeneralButton(
              onPressed: () =>
                  navigationService.navigateTo(RouteName.biometrics),
              buttonTextColor: Colors.white,
              child: const Text(
                'Confirm Code',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  
  }
}