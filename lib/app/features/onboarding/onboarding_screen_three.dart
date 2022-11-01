import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../../app/extensions/sized_context.dart';

class OnboardingScreenThree extends StatelessWidget {
  const OnboardingScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: <Widget>[
          SizedBox(height: context.heightPx * 0.014),
          SvgPicture.asset(
            'assets/images/onboarding3.svg',
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
          SizedBox(height: context.heightPx * 0.09),
          AppText(
            text: 'Simple Payback Plans',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
            size: context.widthPx * 0.065,
          ),
          SizedBox(height: context.heightPx * 0.01),
          AppText(
            text: 'No hidden charges',
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
            size: context.widthPx * 0.03,
          ),
        ],
      ),
    );
  }
}
