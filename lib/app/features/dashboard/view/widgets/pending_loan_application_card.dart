import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_loan_details.dart';
import 'package:floatr/app/features/loan/model/responses/user_subscribed_loan_response.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';

class PendingLoanApplicationCard extends StatefulWidget {
  const PendingLoanApplicationCard({
    super.key,
  });

  @override
  State<PendingLoanApplicationCard> createState() =>
      _PendingLoanApplicationCardState();
}

class _PendingLoanApplicationCardState
    extends State<PendingLoanApplicationCard> {
  @override
  void initState() {
    final loan = context.read<AuthenticationProvider>().user!.loan!;

    final loanId =
        loan.pendingLoanApplicationId ?? loan.settlingLoanApplicationId;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<LoanProvider>().getUserSubscribedLoan(loanId!);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationService = di<NavigationService>();
    final user = context.read<AuthenticationProvider>().user;

    return Consumer<LoanProvider>(
      builder: (context, provider, _) {
        switch (provider.loadingState) {
          case LoadingState.busy:
          case LoadingState.error:
          case LoadingState.loaded:
            final userloan = provider.userSubscribedLoanResponse;
            return Container(
              height: 416,
              width: context.widthPx,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const VerticalSpace(size: 48),
                          SvgPicture.asset(
                            "assets/images/main-logo.svg",
                            height: 24,
                          ),
                          const VerticalSpace(size: 12),
                          Text(
                            'Hi ${user!.firstName},',
                            style: TextStyles.smallTextDark,
                          ),
                          const VerticalSpace(size: 12),

                          Text(
                            '''Your application is currently''',
                            style: TextStyles.largeTextDarkPoppins22,
                          ),
                          const VerticalSpace(size: 7),

                          /// pending approval ui
                          if (userloan?.status ==
                              LoanAppLicationStatus.pendingApproval) ...[
                            RichText(
                              text: TextSpan(
                                text: 'pending approval',
                                style: TextStyles.largeTextPrimary22,
                              ),
                            ),
                          ]

                          /// pending disbursement ui
                          else if (userloan?.status ==
                              LoanAppLicationStatus.pendingDisbursment) ...[
                            RichText(
                              text: TextSpan(
                                text: 'pending disbursement.',
                                style: TextStyles.largeTextPrimary22,
                              ),
                            ),
                          ] else if (userloan?.status ==
                              LoanAppLicationStatus.approved) ...[
                            RichText(
                              text: TextSpan(
                                text:
                                    '           approved but \n pending disbursement.',
                                style: TextStyles.largeTextPrimary22,
                              ),
                            ),
                          ] else ...[
                            RichText(
                              text: TextSpan(
                                text: 'pending',
                                style: TextStyles.largeTextPrimary22,
                              ),
                            ),
                          ],

                          //
                          const VerticalSpace(
                            size: 50,
                          ),
                          Center(
                              child: GeneralButton(
                            onPressed: () => navigationService.navigateTo(
                                RouteName.dashboardLoanDueTime,
                                arguments: DashboardLoanDetailsArguments(
                                    dashboardLoanView:
                                        DashboardLoanView.loanDetailSchedule)),
                            width: 200,
                            height: 35,
                            borderRadius: 10,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'VIEW DETAILS',
                                  style: TextStyle(fontSize: 11.0),
                                ).paddingOnly(right: 10),
                                SvgPicture.asset('assets/icons/fill/arrow.svg',
                                    height: 8, width: 8),
                              ],
                            ),
                          ))
                        ],
                      ).paddingOnly(left: 26, right: 26),
                      const VerticalSpace(size: 48),
                    ],
                  ),
                ],
              ),
            );

          default:
            return Container();
        }
      },
    );
  }
}
