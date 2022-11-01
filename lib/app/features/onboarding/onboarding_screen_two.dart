import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/app_colors.dart';
import '../../widgets/app_text.dart';
import '../../../app/extensions/sized_context.dart';

class OnboardingScreenTwo extends StatelessWidget {
  const OnboardingScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        children: <Widget>[
          SizedBox(height: context.heightPx * 0.092),
          SvgPicture.asset(
            'assets/images/onboarding2.svg',
            fit: BoxFit.fitWidth,
            width: size.width,
          ),
          SizedBox(height: context.heightPx * 0.09),
          AppText(
            text: 'Enjoy the Best Rates',
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
            size: context.widthPx * 0.065,
          ),
          SizedBox(height: context.heightPx * 0.01),
          AppText(
            text: 'Interest rates less than 20%',
            color: AppColors.grey,
            fontWeight: FontWeight.w600,
            size: context.widthPx * 0.03,
          ),
        ],
      ),
    );
  }
}
