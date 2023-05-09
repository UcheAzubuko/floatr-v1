import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/misc/helper_functions.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/general_button.dart';
import '../../../loan/model/responses/loans_response.dart';
import '../../../loan/view/screens/loan_application_screen.dart';

class HighlightsInfoCard extends StatelessWidget {
  const HighlightsInfoCard({Key? key, required this.loan}) : super(key: key);

  final Loan loan;

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // info
        Container(
          height: 144,
          width: 290,
          padding: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              // details
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // amount
                  SizedBox(
                    height: 54,
                    width: 120.19,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset('assets/icons/fill/wallet.svg',
                                    height: 24, width: 21)
                                .paddingOnly(right: 5),
                            Text(
                              'Amount:',
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
                              '₦${formatAmount(doubleStringToIntString(loan.displayedAmountOnCard.toString())!)}',
                              style: TextStyles.normalTextDarkF600,
                            ).paddingOnly(right: 6),
                            Container(
                              width: 33,
                              height: 14,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(SvgAppIcons.icSignalArrowUp),
                                   AppText(
                                    text: '${formatAmount(doubleStringToIntString(loan.interestCharge)!)}%',
                                    size: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).paddingOnly(left: 20),

                  const HorizontalSpace(size: 10),

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
                  ).paddingOnly(top: 5, bottom: 5, right: 27),

                  // Spacer(),

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
                              'Tenure:',
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
                              '${loan.maxTenureInDays} Days',
                              style: TextStyles.normalTextDarkF600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // button
              GeneralButton(
                width: 245,
                height: 30,
                onPressed: () =>
                    navigationService.navigateToRoute(LoanApplicationScreen(
                  loan: loan,
                )),
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
        ),
      ],
    );
  }
}
