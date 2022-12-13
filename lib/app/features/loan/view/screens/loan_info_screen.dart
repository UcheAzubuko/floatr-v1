import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/general_button.dart';

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
                  image: AssetImage(AppImages.successfulImage), fit: BoxFit.cover),
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
            onPressed: () {},
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
    return LoanApplicationInformationBaseView(
      child: Column(),
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
    return LoanApplicationInformationBaseView(
      child: Column(),
    );
  }
}

class LoanSummaryScreen extends StatelessWidget {
  const LoanSummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      child: Column(),
    );
  }
}

class LoanApplicationSuccessfulScreen extends StatelessWidget {
  const LoanApplicationSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      child: Column(),
    );
  }
}
