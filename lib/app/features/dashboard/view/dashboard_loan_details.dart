import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/pageview_toggler.dart';
import '../../loan/view/screens/loan_info_screen.dart';

class DashoardLoanDetails extends StatelessWidget {
  const DashoardLoanDetails({super.key, required this.dashboardLoanView});

  final DashboardLoanView dashboardLoanView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.widthPx,
          child: _view(dashboardLoanView),
        ),
      ),
    );
  }
}

Widget _view(DashboardLoanView dashboardLoanView) {
  switch (dashboardLoanView) {
    case DashboardLoanView.loanDueTime:
      return const DashboardLoanDueTime();
    case DashboardLoanView.loanDetailSchedule:
      return const DashboardLoanDetailSchedule();
    default:
      return const DashboardLoanDueTime();
  }
}

enum DashboardLoanView { loanDueTime, loanDetailSchedule }

class DashboardLoanDetailsArguments {
  final DashboardLoanView dashboardLoanView;
  DashboardLoanDetailsArguments({required this.dashboardLoanView});
}

class DashboardLoanDueTime extends StatelessWidget {
  const DashboardLoanDueTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Column(
      children: [
        const VerticalSpace(
          size: 20,
        ),
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
                        text: ' 10 days', style: TextStyles.largeTextPrimary),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          'Loan Details',
          style: TextStyles.normalTextDarkF600,
        ),
        const VerticalSpace(
          size: 5,
        ),
        Text(
          'Details of existing loan',
          style: TextStyles.smallTextGrey,
        ),

        const VerticalSpace(
          size: 15,
        ),

        // loan info box A
        Container(
          height: 184,
          width: context.widthPx,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // principal
              LoanSummaryRow(
                itemTitle: 'Principal',
                itemData: '₦20,000',
              ),

              //interest
              LoanSummaryRow(
                itemTitle: 'Interest',
                itemData: '₦1000 (5%)',
              ),

              //platform
              LoanSummaryRow(
                itemTitle: 'Platform Fee',
                itemData: '₦4000 (20%)',
              ),

              // payback amount
              LoanSummaryRow(
                itemTitle: 'Payback Amount',
                itemData: '₦25,000',
              ),
            ],
          ),
        ),

        // loan info box B
        const VerticalSpace(
          size: 18,
        ),

        // loan info box B
        Container(
          height: 144,
          width: context.widthPx,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // loan tenure
              LoanSummaryRow(
                itemTitle: 'Loan Tenure',
                itemData: '2 Weeks',
              ),

              //No of Payments
              LoanSummaryRow(
                itemTitle: 'No of Payments',
                itemData: '2 * ₦12,500 (Weekly)',
              ),

              //next payment
              LoanSummaryRow(
                itemTitle: 'Next Payment',
                itemData: '21 Dec 22',
              ),
            ],
          ),
        ),

        const VerticalSpace(
          size: 18,
        ),

        Container(
          height: 144,
          width: context.widthPx,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // loan tenure
              LoanSummaryRow(
                itemTitle: 'Loan Tenure',
                itemData: '2 Weeks',
              ),

              //No of Payments
              LoanSummaryRow(
                itemTitle: 'No of Payments',
                itemData: '2 * ₦12,500 (Weekly)',
              ),

              //next payment
              LoanSummaryRow(
                itemTitle: 'Next Payment',
                itemData: '21 Dec 22',
              ),
            ],
          ),
        ),

        const VerticalSpace(
          size: 30,
        ),
        GeneralButton(
          height: 42,
          onPressed: () => navigationService.navigateTo(
              RouteName.dashboardLoanDueTime,
              arguments: DashboardLoanDetailsArguments(
                  dashboardLoanView: DashboardLoanView.loanDetailSchedule)),
          borderRadius: 8,
          child: const AppText(
            text: 'REPAY LOAN',
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const VerticalSpace(
          size: 30,
        ),
      ],
    );
  }
}

class DashboardLoanDetailSchedule extends StatefulWidget {
  const DashboardLoanDetailSchedule({Key? key}) : super(key: key);

  @override
  State<DashboardLoanDetailSchedule> createState() =>
      _DashboardLoanDetailScheduleState();
}

class _DashboardLoanDetailScheduleState
    extends State<DashboardLoanDetailSchedule> {
  TogglePosition togglePosition = TogglePosition.left;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: () => setState(() {
                  togglePosition = toggle;
                }),
            child: PageViewToggler(
              togglePosition: togglePosition,
              viewName: const ['Details', 'Schedule'],
            )),
        const VerticalSpace(
          size: 24,
        ),
        togglePosition == TogglePosition.left
            ? const LoanDetailsView()
            : const LoanScheduleView()
      ],
    );
  }

  TogglePosition get toggle => togglePosition == TogglePosition.left
      ? TogglePosition.right
      : TogglePosition.left;
}

class LoanScheduleView extends StatelessWidget {
  const LoanScheduleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                        text: ' 10 days', style: TextStyles.largeTextPrimary),
                    // TextSpan(text: ' world!'),
                  ],
                ),
              ),
            ],
          ),
        ),
        

        // loan info box A
        Container(
          height: 184,
          width: context.widthPx,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // principal
              LoanSummaryRow(
                itemTitle: 'Principal',
                itemData: '₦20,000',
              ),

              //interest
              LoanSummaryRow(
                itemTitle: 'Interest',
                itemData: '₦1000 (5%)',
              ),

              //platform
              LoanSummaryRow(
                itemTitle: 'Platform Fee',
                itemData: '₦4000 (20%)',
              ),

              // payback amount
              LoanSummaryRow(
                itemTitle: 'Payback Amount',
                itemData: '₦25,000',
              ),
            ],
          ),
        ),

        // loan info box B
        const VerticalSpace(
          size: 18,
        ),

        // loan info box B
        Container(
          height: 144,
          width: context.widthPx,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // loan tenure
              LoanSummaryRow(
                itemTitle: 'Loan Tenure',
                itemData: '2 Weeks',
              ),

              //No of Payments
              LoanSummaryRow(
                itemTitle: 'No of Payments',
                itemData: '2 * ₦12,500 (Weekly)',
              ),

              //next payment
              LoanSummaryRow(
                itemTitle: 'Next Payment',
                itemData: '21 Dec 22',
              ),
            ],
          ),
        ),

        const VerticalSpace(
          size: 18,
        ),

        Container(
          height: 144,
          width: context.widthPx,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // loan tenure
              LoanSummaryRow(
                itemTitle: 'Loan Tenure',
                itemData: '2 Weeks',
              ),

              //No of Payments
              LoanSummaryRow(
                itemTitle: 'No of Payments',
                itemData: '2 * ₦12,500 (Weekly)',
              ),

              //next payment
              LoanSummaryRow(
                itemTitle: 'Next Payment',
                itemData: '21 Dec 22',
              ),
            ],
          ),
        ),

        
        const VerticalSpace(
          size: 30,
        ),
      ],
    );
 
    
  }
}

class LoanDetailsView extends StatelessWidget {
  const LoanDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // loan info box A
        Container(
          height: 184,
          width: context.widthPx,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              // principal
              LoanSummaryRow(
                itemTitle: 'Principal',
                itemData: '₦20,000',
              ),

              //interest
              LoanSummaryRow(
                itemTitle: 'Interest',
                itemData: '₦1000 (5%)',
              ),

              //platform
              LoanSummaryRow(
                itemTitle: 'Platform Fee',
                itemData: '₦4000 (20%)',
              ),

              // payback amount
              LoanSummaryRow(
                itemTitle: 'Payback Amount',
                itemData: '₦25,000',
              ),
            ],
          ),
        ),

        const VerticalSpace(
          size: 24,
        ),

        Container(
          height: 184,
          width: context.widthPx,
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.lightGrey1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectBank(
                  color: AppColors.primaryColorLight.withOpacity(0.25),
                  bankName: 'United Bank for Africa',
                  bankNumber: '2139872309'),
              Container(
                height: 72,
                width: context.widthPx,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColorLight.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    // image and container
                    Container(
                      height: 109,
                      width: 64,
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(
                        AppImages.card,
                        fit: BoxFit.fitHeight,
                      ),
                    ),

                    const HorizontalSpace(
                      size: 8,
                    ),

                    // bank name and number column
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // name
                          Text(
                            'John Doe',
                            style: TextStyles.smallTextDark14Px,
                          ),

                          const VerticalSpace(
                            size: 5,
                          ),

                          // bank num
                          const Text(
                            '• • • •     • • • •    • • • •    5318',
                            // style: TextStyles.smallTextGrey,
                            style: TextStyle(
                                wordSpacing: 0,
                                color: AppColors.grey500,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
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

