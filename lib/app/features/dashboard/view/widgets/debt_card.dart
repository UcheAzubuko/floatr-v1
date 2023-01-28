import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import 'due_debt_info_card.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 416,
      // color: AppColors.primaryColor,
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // bg overlay
          SvgPicture.asset(
            width: context.widthPx,
            SvgImages.dashboardAuthBackground,
            fit: BoxFit.fitWidth,
            clipBehavior: Clip.hardEdge,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // progress bar
                  Column(
                    children: [
                      CircularPercentIndicator(
                        radius: 110.0,
                        backgroundColor: Colors.white,
                        percent: .7,
                        lineWidth: 10,
                        backgroundWidth: 15,
                        progressColor: AppColors.primaryColor,
                        fillColor: Colors.transparent,
                        circularStrokeCap: CircularStrokeCap.round,
                        arcBackgroundColor: AppColors.grey.withOpacity(0.4),
                        arcType: ArcType.CUSTOM,
                        center: Column(
                          children: [
                            const VerticalSpace(size: 48),
                            SvgPicture.asset(
                              "assets/images/main-logo.svg",
                              height: 24,
                              // fit: BoxFit.cover,
                            ),
                            const VerticalSpace(size: 10),
                            Text(
                              'Your next payment is due',
                              style: TextStyles.smallTextDark,
                            ),
                            const VerticalSpace(size: 7),
                            RichText(
                              text: TextSpan(
                                text: 'in',
                                style: TextStyles.largeTextDark,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ' 10 days',
                                      style: TextStyles.largeTextPrimary),
                                  // TextSpan(text: ' world!'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // card
              const DueDebtInfoCard(),
            ],
          ),
        ],
      ),
    );
  }
}
