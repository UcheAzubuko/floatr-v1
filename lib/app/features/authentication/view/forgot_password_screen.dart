import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final NavigationService navigationService = di<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: 'Forgot Password',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),
            AppText(
              text:
                  'Please enter the phone number associated with your account to reset your password.',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),
            const VerticalSpace(
              size: 40,
            ),
            AppText(
              text: 'Phone number',
              color: AppColors.black,
              fontWeight: FontWeight.w700,
              size: context.widthPx * 0.035,
            ),
            const VerticalSpace(size: 10),
            AppTextField(
              prefixIcon: Padding(
                padding: EdgeInsets.all(context.diagonalPx * 0.01),
                child: SizedBox(
                  child: SvgPicture.asset(
                    'assets/icons/fill/nigeria-flag.svg',
                  ),
                ),
              ),
              hintText: '+234 813 123 4567',
              controller: TextEditingController(),
              textInputType: TextInputType.phone,
              textInputAction: TextInputAction.unspecified,
            ),
            const Spacer(),
            GeneralButton(
              onPressed: () =>
                  navigationService.navigateTo(RouteName.forgotPasswordOtp),
              buttonTextColor: Colors.white,
              child: const Text(
                'VERIFY PHONE NUMBER',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
