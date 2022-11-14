import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  NavigationService navigationService = di<NavigationService>();
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
              text: 'Reset Password',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            // sub text
            AppText(
              text: 'Create your new password',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 50),
            // new password text and textfield
            AppText(
              text: 'New Password',
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 10),

            AppTextField(
              hintText: 'Password',
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.unspecified,
            ),

            const VerticalSpace(size: 10),

            // confirm password text and textfield
            AppText(
              text: 'Confirm Password',
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 10),

            AppTextField(
              hintText: 'Passwords must match',
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.unspecified,
            ),

            const Spacer(),

            GeneralButton(
              onPressed: () => AppDialog.showAppDialog(
                  context,
                  const OnSuccessDialogContent(
                    subtext: 'You can now log in with your new password!',
                    isResetPassword: true,
                  )),
              buttonTextColor: Colors.white,
              child: const Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: context.heightPx * 0.03),
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
