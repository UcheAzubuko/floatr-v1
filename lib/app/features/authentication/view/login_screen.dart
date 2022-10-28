import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // getstarted
            AppText(
              text: 'Getting Started',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            // sub text
            AppText(
              text: 'Create an account to continue!',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 30),

            // email text and textfield
            AppText(
              text: 'Email Address',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            // phone number text and textfield
            AppText(
              text: 'Phone number (Linked with BVN)',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            // password text and textfield

            AppText(
              text: 'Password',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            // confirm password text and textfield
            AppText(
              text: 'Confirm Password',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            // dob text and textfield
            AppText(
              text: 'Date of Birth',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            AppText(
              text: 'Have a referral code?',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 0,
                  width: 20,
                  child: Checkbox(
                    value: false,
                    onChanged: (_) {},
                  ),
                ),
                const HorizontalSpace(size: 20),
                AppText(
                  text: 'I accept and agree all to all terms and conditions',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.031,
                ),
              ],
            ),

            GeneralButton(onPressed: (){}, child: const Text('Next'), height: context.heightPx * 0.08,)
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
