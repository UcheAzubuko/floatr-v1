import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_keyboard.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final NavigationService navigationService = di<NavigationService>();
  final OtpFieldController _otpFieldController = OtpFieldController();

  bool? _hasInputtedOTP = false;

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

            SizedBox(
              height: context.heightPx * 0.009,
            ),

            AppText(
              text: 'Please enter the code that was sent to:',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            SizedBox(
              height: context.heightPx * 0.009,
            ),

            AppText(
              text: '+2348147990002',
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
              controller: _otpFieldController,
              contentPadding: EdgeInsets.all(context.diagonalPx * 0.02),
              style: GoogleFonts.plusJakartaSans(
                color: AppColors.black,
                fontSize: context.widthPx * 0.075,
                fontWeight: FontWeight.w600,
                textStyle: Theme.of(context).textTheme.bodyText1,
              ),
              onChanged: (str) {
                if (str.length < 4) {
                  setState(() {
                    _hasInputtedOTP = false;
                  });
                } else {
                  setState(() {
                    _hasInputtedOTP = true;
                  });
                }
              },
              outlineBorderRadius: 15,
              inputFormatter: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: AppColors.textFieldBackground.withOpacity(0.4),
                enabledBorderColor: Colors.transparent,
              ),
            ),

            const VerticalSpace(
              size: 60,
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  text: 'Didn\'t get the code?',
                  color: AppColors.greyAsparagus,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.031,
                ),
                SizedBox(
                  width: context.widthPx * 0.009,
                ),
                Container(
                  padding: EdgeInsets.only(
                    bottom: context.heightPx * 0.0006,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.primaryColor,
                        width: context.widthPx * 0.001,
                      ),
                    ),
                  ),
                  child: AppText(
                    text: 'Resend Code',
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                    size: context.widthPx * 0.031,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Container(
            //   child: _hasInputtedOTP!
            //       ? GeneralButton(
            //           onPressed: () =>
            //               navigationService.navigateTo(RouteName.verifyBVN),
            //           buttonTextColor: Colors.white,
            //           child: const Text(
            //             'Verify Phone',
            //             style: TextStyle(color: Colors.white),
            //           ),
            //         )
            //       : DisabledButton(
            //           onPressed: () => _hasInputtedOTP!
            //               ? navigationService.navigateTo(RouteName.verifyOTP)
            //               : null,
            //           buttonTextColor: Colors.white,
            //           child: const Text('Verify Phone'),
            //         ),
            // ),

            CustomKeyboard(),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
