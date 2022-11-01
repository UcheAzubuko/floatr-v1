import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final NavigationService navigationService = di<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
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

              const VerticalSpace(size: 10),

              AppTextField(
                  hintText: 'example@gmail.com',
                  controller: TextEditingController(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified),

              const VerticalSpace(size: 10),

              // phone number text and textfield
              AppText(
                text: 'Phone number (Linked with BVN)',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                  hintText: '+234 813 123 4567',
                  controller: TextEditingController(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified),

              // password text and textfield
              const VerticalSpace(size: 10),

              AppText(
                text: 'Password',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                  hintText: 'Password',
                  controller: TextEditingController(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified),

              // confirm password text and textfield
              const VerticalSpace(size: 10),

              AppText(
                text: 'Confirm Password',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                  hintText: 'Passwords must match',
                  controller: TextEditingController(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified),

              const VerticalSpace(size: 10),

              // dob text and textfield
              AppText(
                text: 'Date of Birth',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                  hintText: 'DD-MM-YYYY',
                  controller: TextEditingController(),
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified),

              const VerticalSpace(size: 30),

              AppText(
                text: 'Have a referral code?',
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 30),

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

              const VerticalSpace(size: 20),

              GeneralButton(
                onPressed: () =>
                    navigationService.navigateTo(RouteName.verifyOTP),
                buttonTextColor: Colors.white,
                child: const Text('Next'),
              )
            ],
          ),
        ).paddingSymmetric(horizontal: context.widthPx * 0.037),
      ),
    );
  }
}
