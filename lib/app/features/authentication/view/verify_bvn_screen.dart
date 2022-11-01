import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/text_field.dart';

class VerifyBVNScreen extends StatefulWidget {
  const VerifyBVNScreen({super.key});

  @override
  State<VerifyBVNScreen> createState() => _VerifyBVNScreenState();
}

class _VerifyBVNScreenState extends State<VerifyBVNScreen> {
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
            // BVN
            AppText(
              text: 'BVN',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.089,
            ),

            AppText(
              text: 'Please enter your Bank Verification Number (BVN)',
              color: AppColors.grey,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(
              size: 40,
            ),

            AppText(
              text: 'BVN',
              color: AppColors.black,
              fontWeight: FontWeight.w600,
              size: context.widthPx * 0.035,
            ),

            const VerticalSpace(size: 10),

            AppTextField(
                hintText: '234353633333',
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.unspecified),

            const VerticalSpace(
              size: 15,
            ),

            RichText(
              text: TextSpan(
                style: GoogleFonts.plusJakartaSans(
                  color: AppColors.gunMetal,
                  fontSize: context.widthPx * 0.031,
                  fontWeight: FontWeight.w600,
                ),
                children: <TextSpan>[
                  const TextSpan(text: 'Don\'t know your BVN? Dial '),
                  TextSpan(
                    text: '*556*0# ',
                    style: GoogleFonts.plusJakartaSans(
                      color: AppColors.primaryColor,
                      fontSize: context.widthPx * 0.031,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(
                    text: 'with the number you used to register it',
                  ),
                ],
              ),
            ),

            const Spacer(),

            GeneralButton(
              onPressed: () =>
                  navigationService.navigateTo(RouteName.takeSelfie),
              buttonTextColor: Colors.white,
              child: const Text(
                'Take Selfie',
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
