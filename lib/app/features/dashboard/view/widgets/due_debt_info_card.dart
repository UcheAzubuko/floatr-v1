import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_loan_details.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/misc/helper_functions.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/general_button.dart';
import '../../../loan/providers/loan_provider.dart';

class DueDebtInfoCard extends StatelessWidget {
  const DueDebtInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSubscribedLoan =
        context.read<LoanProvider>().userSubscribedLoanResponse;

    NavigationService navigationService = di<NavigationService>();

    DateFormat dateFormat = DateFormat('dd MMM yyyy');
    return Container(
      height: 144,
      width: 290,
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
                width: 110.19,
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
                          '₦${formatAmount(doubleStringToIntString(userSubscribedLoan!.paymentSchedules.first.amount)!)}',
                          style: TextStyles.normalTextDarkF600,
                        ).paddingOnly(right: 5),
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
                                text:
                                    '${formatAmount(doubleStringToIntString(userSubscribedLoan.interestCharge)!)}%',
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
              ).paddingOnly(left: 1, bottom: 1),

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
                          dateFormat.format(userSubscribedLoan.paymentSchedules.first.dueDate!),
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
            onPressed: () => navigationService.navigateTo(
                RouteName.dashboardLoanDueTime,
                arguments: DashboardLoanDetailsArguments(
                    dashboardLoanView: DashboardLoanView.loanDetailSchedule)),
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
