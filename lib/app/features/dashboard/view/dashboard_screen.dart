import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/loan/view/screens/loan_application_screen.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/images.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../widgets/prompt_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // greet and profile  pic
            SizedBox(
              width: context.widthPx,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const VerticalSpace(
                        size: 20,
                      ),
                      // greet
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(SvgAppIcons.icMorningSun),
                          const HorizontalSpace(
                            size: 10,
                          ),
                          Text('GOOD MORNING',
                              style: TextStyles.smallTextPrimary),
                        ],
                      ),

                      const VerticalSpace(size: 4),

                      // name
                      Text(
                        'Adanna Erica',
                        style: TextStyles.largeTextDark,
                      ),
                    ],
                  ),

                  // profile pic
                  const CircleAvatar(
                    radius: 23,
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
            ),

            const VerticalSpace(size: 20),

            PromptWidget(
              row: Row(
                children: [
                  SvgPicture.asset(SvgAppIcons.icCaution),
                  const HorizontalSpace(
                    size: 8,
                  ),
                  const Text(
                    'Update your profile to unlock all features!.',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            const VerticalSpace(size: 31),

            // card with progress or card with offers
            // const DebtCard(),

            // const DataCompletionWidget(),

            const HighlightsCard(),

            const VerticalSpace(size: 40),

            // dashboard options
            SizedBox(
              width: context.widthPx,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  OptionsCard(
                    itemName: 'Banks',
                    assetPath: 'assets/icons/fill/bank-icon.svg',
                  ),
                  OptionsCard(
                    itemName: 'Cards',
                    assetPath: 'assets/icons/fill/credit-card.svg',
                  ),
                  OptionsCard(
                    itemName: 'Schedule',
                    assetPath: 'assets/icons/fill/time-schedule.svg',
                  ),
                  OptionsCard(
                    itemName: 'More',
                    assetPath: 'assets/icons/fill/more-icon.svg',
                  ),
                ],
              ),
            ),

            const VerticalSpace(size: 40),

            // recent activities
            Text(
              'Recent Activities',
              style: TextStyles.normalTextDarkF800,
            ),

            const VerticalSpace(
              size: 22,
            ),

            SizedBox(
              height: 256,
              width: context.widthPx,
              child: const ActivitiesList(),
            ),
          ],
        ).paddingOnly(
          left: 10,
          right: 10,
          top: 40,
        ),
      ),
    );
  }
}

class DataCompletionWidget extends StatelessWidget {
  const DataCompletionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 576,
      width: context.widthPx,
      // color: AppColors.primaryColor,
      // padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight,
        borderRadius: BorderRadius.circular(16),
      ),

      child: Stack(
        children: [
          // bg overlay
          SvgPicture.asset(
            width: context.widthPx,
            SvgImages.dashboardUnAuthBackground,
            fit: BoxFit.fitWidth,
            clipBehavior: Clip.hardEdge,
          ),

          Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // floatr logo
                SvgPicture.asset(
                  "assets/images/main-logo.svg",
                  height: 24,
                  // fit: BoxFit.cover,
                ),

                const VerticalSpace(
                  size: 10,
                ),

                // ready.. set
                Text(
                  'Ready... Set...',
                  style: TextStyles.largeTextDarkPoppins600,
                ),

                const VerticalSpace(
                  size: 10,
                ),

                // all cap
                Text(
                  '''Your Floatr journey starts now. Complete your \nprofile to gain access to loan offers just for you.''',
                  style: TextStyles.smallTextDark,
                ),

                const VerticalSpace(
                  size: 34,
                ),

                // personal
                const CriteriaWidget(
                  criteriaTitle: 'Personal Details',
                  criteriaState: CriteriaState.done,
                ),

                const VerticalSpace(
                  size: 20,
                ),

                // gov
                const CriteriaWidget(
                  criteriaTitle: 'Government Issued ID',
                  criteriaState: CriteriaState.pending,
                ),

                const VerticalSpace(
                  size: 20,
                ),

                // res addy
                const CriteriaWidget(
                  criteriaTitle: 'Residential Address',
                  criteriaState: CriteriaState.notDone,
                ),

                const VerticalSpace(
                  size: 20,
                ),

                // employment details
                const CriteriaWidget(
                  criteriaTitle: 'Employment Details',
                  criteriaState: CriteriaState.notDone,
                ),

                const VerticalSpace(
                  size: 20,
                ),

                // next of kin
                const CriteriaWidget(
                  criteriaTitle: 'Next of Kin',
                  criteriaState: CriteriaState.notDone,
                ),

                const VerticalSpace(
                  size: 34,
                ),

                // button
                GeneralButton(
                    height: 48,
                    width: context.widthPx,
                    borderRadius: 12,
                    onPressed: () {},
                    child: const AppText(
                      text: 'LET\'S GO!',
                      color: Colors.white,
                      size: 14,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CriteriaWidget extends StatelessWidget {
  const CriteriaWidget(
      {Key? key, required this.criteriaTitle, required this.criteriaState})
      : super(key: key);

  final String criteriaTitle;
  final CriteriaState criteriaState;

  Widget prefferedIcon(CriteriaState criteriaState) {
    switch (criteriaState) {
      case CriteriaState.done:
        return SvgPicture.asset(
          'assets/icons/fill/tick-circle.svg',
          color: Colors.green,
        );
      case CriteriaState.notDone:
        return SvgPicture.asset(
          'assets/icons/outline/tick-circle.svg',
          color: Colors.grey,
        );
      case CriteriaState.pending:
        return SvgPicture.asset(
          'assets/icons/outline/tick-circle-broken.svg',
          color: Colors.green,
        );
      default:
        return SvgPicture.asset(
          'assets/icons/fill/tick-circle.svg',
          color: Colors.green,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          criteriaTitle,
          style: TextStyles.smallTextDark14Px,
        ),
        CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: prefferedIcon(criteriaState)),
      ],
    );
  }
}

enum CriteriaState { pending, done, notDone }

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (_, __) => SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // icon
                      Container(
                        height: 52,
                        width: 52,
                        // color: AppColors.lightGrey,
                        decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(40)),
                        child: SvgPicture.asset(
                          'assets/icons/outline/transfer_wallet.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                      ).paddingOnly(right: 8),

                      // activity title
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Loan Repaid',
                            style: TextStyles.smallTextDark,
                          ),
                          Text(
                            '18 Oct 2022',
                            style: TextStyles.smallTextGrey,
                          ),
                        ],
                      ),

                      // amount // activity status
                    ],
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '₦10,000',
                          style: TextStyles.smallTextDark,
                        ).paddingOnly(bottom: 10),
                        Container(
                          height: 21,
                          width: 65,
                          decoration: BoxDecoration(
                              color: AppColors.lightGreen,
                              borderRadius: BorderRadius.circular(30)),
                          child: const Center(
                            child: AppText(
                              text: 'Success',
                              color: Colors.green,
                              size: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: 4);
  }
}

class NoActivityView extends StatelessWidget {
  const NoActivityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 110,
          width: 155,
          child: Image.asset('assets/images/analytics-image.png'),
        ),
        Text(
          'No Activity Yet',
          style: TextStyles.normalTextDarkF800,
        ),
        const VerticalSpace(
          size: 10,
        ),
        const Text(
          '''Start taking loans and all your history will 
          appear here''',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

class HighlightsCard extends StatelessWidget {
  const HighlightsCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(size: 48),
                  SvgPicture.asset(
                    "assets/images/main-logo.svg",
                    height: 24,
                  ),
                  const VerticalSpace(size: 12),
                  Text(
                    'Need money urgently?',
                    style: TextStyles.smallTextDark,
                  ),
                  const VerticalSpace(size: 12),
                  Text(
                    '''We have offers just \nfor you!''',
                    style: TextStyles.largeTextDarkPoppins,
                  ),
                ],
              ).paddingOnly(left: 26),
              const VerticalSpace(size: 48),
              SizedBox(
                height: 150,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) =>
                        const HighlightsInfoCard().paddingOnly(
                          left: index == 0 ? 25 : 10,
                          right: index == 3 ? 25 : 0,
                        ), // this gives the first item more padding on the left and last item more padding on the right
                    separatorBuilder: (_, __) => const SizedBox(
                          width: 0,
                        ),
                    itemCount: 4),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class HighlightsInfoCard extends StatelessWidget {
  const HighlightsInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // info
        Container(
          height: 144,
          width: 283,
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
                    width: 104.19,
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
                              '₦5,000',
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
                                  const AppText(
                                    text: '15%',
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
                              '7 Days',
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
                onPressed: () => navigationService
                    .navigateToRoute(const LoanApplicationScreen()),
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

class OptionsCard extends StatelessWidget {
  const OptionsCard(
      {Key? key,
      required this.assetPath,
      this.onPressed,
      required this.itemName})
      : super(key: key);

  final String assetPath;
  final Function()? onPressed;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 66,
            width: 66,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(assetPath),
          ),
          Text(
            itemName,
            style: TextStyles.smallTextDark,
          )
        ],
      ),
    );
  }
}
