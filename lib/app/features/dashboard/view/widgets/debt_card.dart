import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../authentication/providers/authentication_provider.dart';
import '../../../loan/providers/loan_provider.dart';
import 'due_debt_info_card.dart';

class DebtCard extends StatefulWidget {
  const DebtCard({
    Key? key,
  }) : super(key: key);

  @override
  State<DebtCard> createState() => _DebtCardState();
}

class _DebtCardState extends State<DebtCard> {
  @override
  void initState() {
    final loan = context.read<AuthenticationProvider>().user?.loan;

    final loanId =
        loan?.pendingLoanApplicationId ?? loan?.settlingLoanApplicationId;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      WidgetsFlutterBinding.ensureInitialized();
      await context.read<LoanProvider>().getUserSubscribedLoan(loanId!);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final loanProvider = context.read<LoanProvider>();

    return Consumer<LoanProvider>(
      builder: (context, loanProvider, _) {
        final loan = context.read<AuthenticationProvider>().user?.loan;

        final loanId =
            loan?.pendingLoanApplicationId ?? loan?.settlingLoanApplicationId;

        switch (loanProvider.loadingState) {
          case LoadingState.busy:
            return const SizedBox(
              height: 416,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );

          case LoadingState.error:
            return SizedBox(
              height: 416,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppText(
                      text: 'Could not get your loan!',
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      size: 10,
                    ),
                    InkWell(
                      onTap: () => loanProvider.getUserSubscribedLoan(loanId!),
                      child: const AppText(
                        text: ' Please try again.',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        size: 10,
                      ),
                    ),
                  ],
                ),
              ),
            );

          case LoadingState.loaded:
            final userSubscribedLoan = loanProvider.userSubscribedLoanResponse;
            if (userSubscribedLoan == null) {
              return const SizedBox(
                height: 416,
                child: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            }

            DateTime dateNowMinusOneDay =
                DateTime.now().subtract(const Duration(days: 0));

            Duration difference = userSubscribedLoan
                .paymentSchedules.first.dueDate!
                .difference(dateNowMinusOneDay);

            int differenceInDays =
                (difference.inMilliseconds / 86400000).round() < 0
                    ? 0
                    : (difference.inMilliseconds / 86400000).round();

            // DateTime dueDate = userSubscribedLoan.dueDate;

            // int totalDays = userSubscribedLoan.minTenureInDays;
            // print('Total days: $totalDays');

            // int remainingDays = dueDate.difference(DateTime.now()).inDays;
            // print('Remaining days: $remainingDays');

            // double percentageRemaining = 1 - (differenceInDays / totalDays);

            // print('Percentage remaining: $percentageRemaining');

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
                                percent: (userSubscribedLoan.maxTenureInDays -
                                        differenceInDays) /
                                    userSubscribedLoan.maxTenureInDays,
                                lineWidth: 10,
                                backgroundWidth: 15,
                                progressColor: AppColors.primaryColor,
                                fillColor: Colors.transparent,
                                circularStrokeCap: CircularStrokeCap.round,
                                arcBackgroundColor:
                                    AppColors.grey.withOpacity(0.4),
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

                                    // overdue loan
                                    if (differenceInDays <= 0) ...[
                                      Text(
                                        'Your current loan is',
                                        style: TextStyles.smallTextDark,
                                      ),
                                      const VerticalSpace(size: 7),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Overdue!',
                                            style: TextStyles.largeTextPrimary),
                                      ),
                                    ]

                                    // pending payment
                                    else ...[
                                      Text(
                                        'Your current loan is due',
                                        style: TextStyles.smallTextDark,
                                      ),
                                      const VerticalSpace(size: 7),
                                      RichText(
                                        text: TextSpan(
                                          text: 'in',
                                          style: TextStyles.largeTextDark,
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: ' $differenceInDays days',
                                                style: TextStyles
                                                    .largeTextPrimary),
                                            // TextSpan(text: ' world!'),
                                          ],
                                        ),
                                      ),
                                    ]
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

          default:
            return Container();
        }
      },
    );
  }
}
