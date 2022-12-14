import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/prompt_widget.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/general_button.dart';
import '../../../../widgets/text_field.dart';

class LoanApplicationInformationBaseView extends StatelessWidget {
  const LoanApplicationInformationBaseView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Loan Application',
          useInAppArrow: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ));
  }
}

class IneligibleScreen extends StatelessWidget {
  const IneligibleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpace(
            size: 55,
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
            '''Oops! You are not eligible for this loan!''',
            style: TextStyles.normalTextDarkF800,
          ),

          const VerticalSpace(
            size: 17,
          ),

          // comple profile text
          Text(
            '''Don’t know why? Please contact our support or \n             try applying for a smaller loan offering.''',
            style: TextStyles.smallTextGrey,
          ),

          const VerticalSpace(
            size: 101,
          ),

          // bottom
          GeneralButton(
            height: 42,
            onPressed: () {},
            borderRadius: 8,
            child: const AppText(
              text: 'CONTACT SUPPORT',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

class EligibleScreen extends StatelessWidget {
  const EligibleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return LoanApplicationInformationBaseView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const VerticalSpace(
            size: 55,
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
                  image: AssetImage(AppImages.successfulImage),
                  fit: BoxFit.cover),
            ),
          ),

          const VerticalSpace(
            size: 53,
          ),

          // error text
          Text(
            '''Congrats! You are eligible for this loan.''',
            style: TextStyles.normalTextDarkF800,
          ),

          const VerticalSpace(
            size: 17,
          ),

          // comple profile text
          Text(
            '''Click continue to complete your application.''',
            style: TextStyles.smallTextGrey,
          ),

          const VerticalSpace(
            size: 101,
          ),

          // bottom
          GeneralButton(
            height: 42,
            onPressed: () =>
                navigationService.navigateToRoute(const AddNewCardScreen()),
            borderRadius: 8,
            child: const AppText(
              text: 'CONTINUE',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

class AddNewCardScreen extends StatelessWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return LoanApplicationInformationBaseView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(
            size: 43,
          ),

          // title
          Text(
            'Add New Card',
            style: TextStyles.largeTextDark,
          ),

          const VerticalSpace(
            size: 9,
          ),

          Text(
            'Please note that a one-time tokenization fee of \n₦100 will be charged to your card.',
            style: TextStyles.smallTextGrey14Px,
          ),

          const VerticalSpace(
            size: 20,
          ),

          SizedBox(
            height: 186,
            width: context.widthPx,
            child: Image.asset(
              AppImages.defaultWallet,
              fit: BoxFit.fitWidth,
            ),
          ),

          const VerticalSpace(
            size: 20,
          ),

          Text(
            'Cardholder Name',
            style: TextStyles.smallTextDark14Px,
          ).paddingOnly(bottom: 8),
          AppTextField(
            controller: TextEditingController(),
            hintText: 'Enter Cardholder Name',
          ),

          const VerticalSpace(
            size: 10,
          ),

          //
          Text(
            'Card Number',
            style: TextStyles.smallTextDark14Px,
          ).paddingOnly(bottom: 8),
          AppTextField(
            controller: TextEditingController(),
            hintText: 'Enter Card Number',
          ),

          const VerticalSpace(
            size: 10,
          ),

          //
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 154,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Expiry Date',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: TextEditingController(),
                      hintText: 'MM/YY',
                    ),
                  ],
                ),
              ),

              //
              SizedBox(
                width: 154,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '3-Digit CVV',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: TextEditingController(),
                      hintText: 'Enter CVV',
                    ),
                  ],
                ),
              ),
            ],
          ),

          const VerticalSpace(
            size: 30,
          ),

          GeneralButton(
            height: 42,
            onPressed: () =>
                navigationService.navigateToRoute(const AddNewBankScreen()),
            borderRadius: 8,
            child: const AppText(
              text: 'CONTINUE',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

class SelectCardScreen extends StatelessWidget {
  const SelectCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      child: Column(),
    );
  }
}

class AddNewBankScreen extends StatelessWidget {
  const AddNewBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return LoanApplicationInformationBaseView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(
            size: 43,
          ),

          // title
          Text(
            'Add New Bank',
            style: TextStyles.largeTextDark,
          ),

          const VerticalSpace(
            size: 9,
          ),

          Text(
            'What bank account would you like us to send the \nfunds to?',
            style: TextStyles.smallTextGrey14Px,
          ),

          const VerticalSpace(
            size: 20,
          ),

          PromptWidget(
            row: Row(
              children: [
                SvgPicture.asset(SvgAppIcons.icCaution),
                const HorizontalSpace(
                  size: 8,
                ),
                const Text(
                  'Account Name should match your registered \nname.',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          const VerticalSpace(
            size: 20,
          ),

          Text(
            'Select Bank',
            style: TextStyles.smallTextDark14Px,
          ).paddingOnly(bottom: 8),
          AppTextField(
            controller: TextEditingController(),
            // hintText: 'Enter Cardholder Name',
          ),

          const VerticalSpace(
            size: 32,
          ),

          //
          Text(
            'Account Number',
            style: TextStyles.smallTextDark14Px,
          ).paddingOnly(bottom: 8),
          AppTextField(
            controller: TextEditingController(),
            hintText: 'Enter your Account number',
          ),
          //

          const VerticalSpace(
            size: 194,
          ),

          GeneralButton(
            height: 42,
            onPressed: () =>
                navigationService.navigateToRoute(const LoanSummaryScreen()),
            borderRadius: 8,
            child: const AppText(
              text: 'CONTINUE',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}

class LoanSummaryScreen extends StatelessWidget {
  const LoanSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return LoanApplicationInformationBaseView(
      child: SizedBox(
        width: context.widthPx,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                AppImages.summaryDocument,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              'Loan Summary',
              style: TextStyles.largeTextDark,
            ),
            const VerticalSpace(
              size: 9,
            ),
            Text(
              'Please confirm the details of your loan.',
              style: TextStyles.smallTextGrey14Px,
            ),
            Container(
              height: 184,
              width: context.widthPx,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.lightGrey1),
            ),
            const VerticalSpace(
              size: 18,
            ),
            Container(
              height: 184,
              width: context.widthPx,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.lightGrey1),
            ),
            const VerticalSpace(
              size: 18,
            ),
            Container(
              height: 184,
              width: context.widthPx,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.lightGrey1),
            ),
            const VerticalSpace(
              size: 30,
            ),
            GeneralButton(
              height: 42,
              onPressed: () => navigationService
                  .navigateToRoute(const LoanApplicationSuccessfulScreen()),
              borderRadius: 8,
              child: const AppText(
                text: 'CONFIRM & APPLY',
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const VerticalSpace(
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class LoanApplicationSuccessfulScreen extends StatelessWidget {
  const LoanApplicationSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      child: SizedBox(
        width: context.widthPx,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const VerticalSpace(
              size: 115,
            ),

            // rocket
            SizedBox(
              height: 270,
              width: 250,
              child: Image.asset(AppImages.rocketLaunch),
            ),

            const VerticalSpace(
              size: 53,
            ),

            Text(
              '''Application Successful!''',
              style: TextStyles.normalTextDarkF800,
            ),

            const VerticalSpace(
              size: 17,
            ),

            // comple profile text
            Text(
              '''You should recieve funds in your linked account \n  \n                                          in a few minutes.''',
              style: TextStyles.smallTextGrey,
            ),

            const VerticalSpace(
              size: 68,
            ),

            InkWell(
              onTap: () {},
              child: Text(
                'Back to Dashboard'.toUpperCase(),
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
