import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/providers/base_provider.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_keyboard.dart';
import '../../../../widgets/dialogs.dart';
import '../../../../widgets/general_button.dart';
import '../../../authentication/providers/authentication_provider.dart';
import 'highlights_info_card.dart';

class HighlightsCard extends StatefulWidget {
  const HighlightsCard({
    Key? key,
  }) : super(key: key);

  @override
  State<HighlightsCard> createState() => _HighlightsCardState();
}

class _HighlightsCardState extends State<HighlightsCard> {
  @override
  void initState() {
    final user = context.read<AuthenticationProvider>().user;
    // Provider.of<LoanProvider>(context).getFeaturedLoans();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => user!.hasSetPin! ? null : _proceed(TransactionPinState.initial),
    );
    super.initState();
  }

  _proceed(TransactionPinState transPinState, {String? setInitialPin}) {
    final bool isInitial = transPinState == TransactionPinState.initial;
    // set tempPin as setInitialPin for comparison, if setInitial pin is null,
    // it therefore means there exists no other pin to compare with.
    String? tempPin = setInitialPin;
    AppDialog.showAppDialog(
        context,
        ChangeNotifierProvider(
          create: (context) => KeyboardProvider()
            ..updateControllerActiveStatus(shouldDeactivateController: true)
            ..updateRequiredLength(6),
          child: Consumer<KeyboardProvider>(
            builder: (context, keyboard, _) {
              final authProvider = this.context.read<AuthenticationProvider>();
              return Container(
                // height: 741,
                width: context.widthPx,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(24)),
                child: Column(
                  children: [
                    Container(
                      width: 38,
                      height: 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.grey.withOpacity(0.3),
                      ),
                    ),

                    const VerticalSpace(size: 25),

                    SizedBox(
                      height: 75,
                      child: Column(
                        children: [
                          Text(
                            isInitial
                                ? 'Create Your Transactional Pin'
                                : 'Confirm Pin',
                            style: TextStyles.normalTextDarkF800,
                          ),
                          const VerticalSpace(
                            size: 20,
                          ),
                          SizedBox(
                            width: 152,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                pinCircle(0, keyboard.inputs),
                                pinCircle(1, keyboard.inputs),
                                pinCircle(2, keyboard.inputs),
                                pinCircle(3, keyboard.inputs),
                                pinCircle(4, keyboard.inputs),
                                pinCircle(5, keyboard.inputs),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),

                    const CustomKeyboard(),

                    const Spacer(),

                    // btn
                    GeneralButton(
                      height: 48,
                      width: 335,
                      borderColor: keyboard.isFilled
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight.withOpacity(0.1),
                      backgroundColor: keyboard.isFilled
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight.withOpacity(0.1),
                      borderRadius: 12,
                      isLoading: authProvider.loadingState == LoadingState.busy,
                      onPressed: isInitial
                          // switch to to confirm
                          ? () {
                              if (keyboard.isFilled) {
                                // list of keyboard inputs to string
                                final pin = keyboard.inputs
                                    .map((n) => n.toString())
                                    .join();

                                di<NavigationService>().pop(); // pop dialog
                                // call proceed again, but with the initial entered pin so you can compare against subsequent entered pin.
                                _proceed(TransactionPinState.confirm,
                                    setInitialPin:
                                        pin); // show comfirm pin dialog
                              }
                            }
                          // confirm pin
                          : () async {
                              if (keyboard.isFilled) {
                                final pin = keyboard.inputs
                                    .map((n) => n.toString())
                                    .join();

                                if (tempPin != null) {
                                  // compare both pins
                                  if (tempPin != pin) {
                                    Fluttertoast.showToast(
                                        msg: 'Both PINs do not match!',
                                        backgroundColor: Colors.red);
                                  } else {
                                    authProvider.updateTransactionPin(pin);
                                    await authProvider
                                        .createPin()
                                        .then((value) {
                                      di<NavigationService>()
                                          .pop(); // pop dialog
                                      // show success confirmation
                                      Fluttertoast.showToast(
                                          msg: 'Transaction PIN created.',
                                          backgroundColor: Colors.blue);
                                    });
                                  }
                                }
                              }
                            },
                      child: const AppText(
                        text: 'ENTER',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        size: 14,
                      ),
                    ).paddingOnly(left: 14, right: 14, bottom: 43),
                  ],
                ),
              );
            },
          ),
        ),
        height: 541,
        width: 335);
  }

  CircleAvatar pinCircle(int mappedNum, nums) {
    // var nums = context.read<KeyboardProvider>().inputs;
    return CircleAvatar(
      radius: 5,
      backgroundColor: nums.asMap().containsKey(mappedNum)
          ? AppColors.primaryColor
          : AppColors.grey.withOpacity(0.5),
    );
  }

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
              Consumer<LoanProvider>(
                builder: (context, provider, _) {
                  switch (provider.loadingState) {
                    // loading
                    case LoadingState.busy:
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    // loaded
                    case LoadingState.loaded:
                      // final loans = provider.loansResponse!.loans;
                      if (provider.loansResponse == null) {
                        const SizedBox(
                          height: 150,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 150,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) => HighlightsInfoCard(
                                  loan: provider.loansResponse!.loans[index],
                                ).paddingOnly(
                                  left: index == 0 ? 25 : 10,
                                  right: index ==
                                          provider.loansResponse!.loans.length -
                                              1
                                      ? 25
                                      : 0,
                                ), // this gives the first item more padding on the left and last item more padding on the right
                            separatorBuilder: (_, __) => const SizedBox(
                                  width: 0,
                                ),
                            itemCount: provider.loansResponse!.loans.length),
                      );
                    default:
                      return const SizedBox(
                        height: 150,
                        child: Center(
                          child: Text('Couldn\'t get loans'),
                        ),
                      );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
