
import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/general_button.dart';

class DueDebtInfoCard extends StatelessWidget {
  const DueDebtInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      width: 288,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // amount
              SizedBox(
                height: 54,
                width: 109.19,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/fill/wallet.svg',
                                height: 24, width: 21)
                            .paddingOnly(right: 5),
                        Text(
                          'Amount Due:',
                          style: TextStyles.smallerTextDark,
                        ),
                      ],
                    ),
                    const VerticalSpace(
                      size: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          '₦10,000',
                          style: TextStyles.normalTextDarkF600,
                        ).paddingOnly(right: 6),
                        Container(
                          width: 33,
                          height: 14,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // dotted border
              DottedBorder(
                color: AppColors.grey,
                strokeWidth: 0,
                padding: const EdgeInsets.all(0),
                borderType: BorderType.RRect,
                child: const SizedBox(
                  height: 90,
                  width: 0,
                ),
              ),

              // due date
              SizedBox(
                height: 54,
                width: 104.19,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/fill/clock.svg',
                                height: 24, width: 21)
                            .paddingOnly(right: 5),
                        Text(
                          'Due Date:',
                          style: TextStyles.smallerTextDark,
                        ),
                      ],
                    ),
                    const VerticalSpace(
                      size: 6,
                    ),
                    Row(
                      children: [
                        Text(
                          '11 Oct 2022',
                          style: TextStyles.normalTextDarkF600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          GeneralButton(
            width: 245,
            height: 30,
            onPressed: () {},
            borderRadius: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                  size: 12,
                  text: 'VIEW DETAILS',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ).paddingOnly(right: 8),
                SvgPicture.asset('assets/icons/fill/arrow.svg',
                    height: 8, width: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}