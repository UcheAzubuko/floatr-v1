import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/images/main-logo.svg",
                    fit: BoxFit.scaleDown,
                    height: context.heightPx * 0.035,
                    width: context.widthPx * 0.035,
                  ),
                  AppText(
                    text: 'floatr',
                    size: context.widthPx * 0.035,
                    color: AppColors.black,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),

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
                color: AppColors.black,
                fontWeight: FontWeight.w600,
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

              const VerticalSpace(size: 10),

              // password text and textfield
              AppText(
                text: 'Password',
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

              GestureDetector(
                onTap: () =>
                    navigationService.navigateTo(RouteName.forgotPassword),
                child: AppText(
                  text: 'Forgot Password?',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.035,
                ),
              ),

              const VerticalSpace(size: 100),

              GeneralButton(
                // onPressed: () =>
                //     navigationService.navigateTo(RouteName.createPin),
                onPressed: () {},
                child: const Text('Login'),
              ),

              SizedBox(height: context.heightPx * 0.03),

              GestureDetector(
                onTap: () => navigationService.navigateTo(RouteName.signup),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        color: AppColors.black,
                        fontSize: context.widthPx * 0.04,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        const TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                          text: 'Sign Up',
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
