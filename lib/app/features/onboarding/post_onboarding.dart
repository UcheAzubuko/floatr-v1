import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/misc/dependency_injectors.dart';
import '../../../core/route/navigation_service.dart';
import '../../../core/route/route_names.dart';
import '../../../core/utils/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../../app/extensions/sized_context.dart';
import '../../widgets/general_button.dart';

class PostOnboarding extends StatelessWidget {
  const PostOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: <Widget>[
              SizedBox(height: context.heightPx * 0.09),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
              SvgPicture.asset(
                'assets/images/post-onboarding.svg',
                fit: BoxFit.cover,
                width: size.width,
              ),
              SizedBox(height: context.heightPx * 0.09),
              AppText(
                text: 'Ease, Speed & Freedom',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w800,
                size: context.widthPx * 0.065,
              ),
              SizedBox(height: context.heightPx * 0.01),
              AppText(
                text: 'The Floatr Experience',
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.03,
              ),
              SizedBox(height: context.heightPx * 0.06),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: context.widthPx * 0.037),
                child: GeneralButton(
                  onPressed: () =>
                      // navigationService.navigateTo(RouteName.dashboard),
                      navigationService.navigateTo(RouteName.signup),
                  child: const Text('Create Account'),
                ),
              ),
              SizedBox(height: context.heightPx * 0.03),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: context.widthPx * 0.037),
                child: GestureDetector(
                  onTap: () => navigationService.navigateTo(RouteName.login),
                  child: Center(
                    child: RichText(
                      text: TextSpan(
                        style: GoogleFonts.plusJakartaSans(
                          color: AppColors.black,
                          fontSize: context.widthPx * 0.03,
                          fontWeight: FontWeight.w600,
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Sign in',
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
              ),
            ],
          ),
        ));
  }
}
