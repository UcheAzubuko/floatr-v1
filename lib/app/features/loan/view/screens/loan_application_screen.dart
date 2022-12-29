import 'dart:async';

import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/loan/view/screens/loan_info_screen.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/images.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/prompt_widget.dart';

class LoanApplicationScreen extends StatelessWidget {
  const LoanApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: context.widthPx,
          child: _view(LoanApplicationView.eligible),
        ),
      ),
    );
  }
}

Widget _view(LoanApplicationView loanApplicationView) {
  switch (loanApplicationView) {
    case LoanApplicationView.eligible:
      return const EligibleLenderView();
    case LoanApplicationView.ineligible:
      return const IneligibleLenderView();
  }
}

class EligibleLenderView extends StatefulWidget {
  const EligibleLenderView({
    Key? key,
  }) : super(key: key);

  @override
  State<EligibleLenderView> createState() => _EligibleLenderViewState();
}

class _EligibleLenderViewState extends State<EligibleLenderView> {
  double? amount;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VerticalSpace(
          size: 43,
        ),
        Row(
          children: [
            SvgPicture.asset(
              "assets/images/main-logo.svg",
              height: 30,
              fit: BoxFit.fill,
            ),

            Text(
              'floatr',
              style: TextStyles.normalTextDarkF800,
            ),

            // tit;
          ],
        ),

        // title
        Text(
          'Loan Application',
          style: TextStyles.largeTextDark,
        ),

        const VerticalSpace(
          size: 9,
        ),

        Text(
          'Choose your preferred loan options.',
          style: TextStyles.smallTextGrey14Px,
        ),

        const VerticalSpace(
          size: 20,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'How much do you need?',
              style: TextStyles.smallTextDark14Px,
            ),
            Text(
              '₦ ${amount ?? 0}',
              style: TextStyles.largeTextDark,
            ),
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const VerticalSpace(
              size: 15,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'from N5,000',
                  style: TextStyles.smallerTextDark10px,
                ),
                Text(
                  'to N50,000',
                  style: TextStyles.smallerTextDark10px,
                ),
              ],
            ),
            UnconstrainedBox(
              // constrainedAxis: Axis.vertical, // retain vertical axis
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                constraints: const BoxConstraints(
                  maxHeight: 30,
                ),
                width: context.widthPx,
                child: FlutterSlider(
                  values: const [5000],
                  max: 50000,
                  min: 5000,
                  step: const FlutterSliderStep(step: 500),
                  onDragging: (handlerIndex, lowerValue, upperValue) {
                    amount = lowerValue;
                    print(amount);
                    setState(() {});
                  },
                  trackBar: FlutterSliderTrackBar(
                    inactiveTrackBar: BoxDecoration(
                        color: AppColors.primaryColorLight,
                        borderRadius: BorderRadius.circular(8)),
                    activeTrackBar: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    activeTrackBarHeight: 6,
                    inactiveTrackBarHeight: 6,
                  ),
                  handler: FlutterSliderHandler(
                    decoration: const BoxDecoration(),
                    child: const CircleAvatar(
                      radius: 9,
                      backgroundColor: AppColors.primaryColor,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const VerticalSpace(
              size: 60,
            ),

            //
            Text(
              'Choose a loan  term',
              style: TextStyles.smallTextDark,
            ).paddingOnly(bottom: 10),
            AppTextField(controller: TextEditingController(text: '1 week')),

            const VerticalSpace(
              size: 26,
            ),

            // loan details
            Container(
              height: 230,
              padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.primaryColor),
                  color: AppColors.primaryColorLight.withOpacity(0.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AppText(
                    text: 'Loan Application',
                    fontWeight: FontWeight.w700,
                  ),
                  const VerticalSpace(
                    size: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // loan amount
                          LoanApplicationInformation(
                            option: 'Loan Amount',
                            optionValue: '20,000',
                          ),

                          VerticalSpace(
                            size: 20,
                          ),

                          // loan tenure
                          LoanApplicationInformation(
                            option: 'Loan Tenure',
                            optionValue: '2 Weeks',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // interest
                          LoanApplicationInformation(
                            option: 'Interest',
                            optionValue: 'N1,000',
                          ),

                          VerticalSpace(
                            size: 20,
                          ),

                          // no of repayments

                          LoanApplicationInformation(
                            option: 'No of Repayments',
                            optionValue: '2 * N12,500',
                          ),

                          // // Payback amount
                          // LoanApplicationInformation(
                          //   option: 'Payback Amount',
                          //   optionValue: 'N25,000',
                          // ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          // // platform
                          LoanApplicationInformation(
                            option: 'Platform Fee',
                            optionValue: 'N4,000',
                          ),

                          VerticalSpace(
                            size: 20,
                          ),

                          // Payback amount
                          LoanApplicationInformation(
                            option: 'Payback Amount',
                            optionValue: 'N25,000',
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpace(
                    size: 22,
                  ),
                  GeneralButton(
                    height: 30,
                    borderRadius: 8,
                    onPressed: () => AppDialog.showAppDialog(
                        context, const CheckingEligibilityDialogContent()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AppText(
                          size: 12,
                          text: 'APPLY',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ).paddingOnly(right: 8),
                        SvgPicture.asset(
                          'assets/icons/fill/arrow.svg',
                          height: 8,
                          width: 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    ).paddingOnly(bottom: 30);
  }
}

class LoanApplicationInformation extends StatelessWidget {
  const LoanApplicationInformation({
    Key? key,
    required this.option,
    required this.optionValue,
  }) : super(
          key: key,
        );

  final String option;
  final String optionValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$option:',
          style: TextStyles.smallerTextDark,
        ),
        const VerticalSpace(
          size: 3,
        ),
        Text(
          optionValue,
          style: TextStyles.normalTextDarkPoppins,
        )
      ],
    );
  }
}

class CheckingEligibilityDialogContent extends StatefulWidget {
  const CheckingEligibilityDialogContent({
    Key? key,
  }) : super(key: key);

  @override
  State<CheckingEligibilityDialogContent> createState() =>
      _CheckingEligibilityDialogContentState();
}

class _CheckingEligibilityDialogContentState
    extends State<CheckingEligibilityDialogContent> {
  NavigationService navigationService = di<NavigationService>();

  @override
  void initState() {
    Timer(
      const Duration(seconds: 1),
      (() => navigationService
        ..pop() // remove dialog
        ..navigateToRoute(
          const EligibleScreen(),
        )),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 38,
          height: 8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.grey.withOpacity(0.3),
          ),
        ),
        const VerticalSpace(
          size: 42,
        ),
        SizedBox(
          height: 116,
          width: 154,
          child: SvgPicture.asset(SvgImages.checkingDocument),
        ),
        const VerticalSpace(
          size: 32,
        ),
        Text(
          'Checking Eligibility...',
          style: TextStyles.normalTextDarkF800,
        ),
        const VerticalSpace(
          size: 22,
        ),
        Text(
          '''Please hold on while we check if you are eligible \n                                               for this loan.''',
          style: TextStyles.smallTextGrey,
        ),
      ],
    );
  }
}

class IneligibleLenderView extends StatelessWidget {
  const IneligibleLenderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const VerticalSpace(
          size: 55,
        ),
        // prompt
        PromptWidget(
          row: Row(
            children: [
              SvgPicture.asset(SvgAppIcons.icCaution),
              const HorizontalSpace(
                size: 8,
              ),
              const Text(
                'Update your profile to unlock all features!',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),

        const VerticalSpace(
          size: 78,
        ),

        // error image
        Container(
          height: 131,
          width: 127,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppImages.walletSad), fit: BoxFit.cover),
          ),
        ),

        const VerticalSpace(
          size: 53,
        ),

        // error text
        Text(
          '''Oops! You are not eligible for \n                     a loan just yet!''',
          style: TextStyles.normalTextDarkF800,
        ),

        const VerticalSpace(
          size: 17,
        ),

        // comple profile text
        Text(
          '''To apply for a loan, you need to complete \n                                        your profile.''',
          style: TextStyles.smallTextGrey,
        ),

        const VerticalSpace(
          size: 73,
        ),

        // bottom
        GeneralButton(
          height: 42,
          onPressed: () {},
          borderRadius: 8,
          child: const AppText(
            text: 'UPDATE PROFILE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }
}

enum LoanApplicationView { ineligible, eligible }
