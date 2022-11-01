import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  NavigationService navigationService = di<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(size: 30),

            // lets sign in
            AppText(
              text: 'Let\'s Sign You In',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            // sub text
            AppText(
              text: 'Welcome back! We\'ve missed you.',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 50),

            // phone number text and textfield
            AppText(
              text: 'Phone number',
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

            const VerticalSpace(size: 10),

            // password text and textfield
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

            const VerticalSpace(size: 100),

            GeneralButton(
              onPressed: () => navigationService.navigateTo(RouteName.createPin),
              child: const Text('Login'),
            ),

            const VerticalSpace(size: 20),

            Center(
              child: AppText(
                text: 'Don\'t have an account? Sign Up',
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.032,
              ),
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
