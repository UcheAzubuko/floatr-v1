import 'dart:developer';

import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/loan/model/responses/user_subscribed_loan_response.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:monnify_payment_sdk/monnify_payment_sdk.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/misc/helper_functions.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/secrets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_style.dart';
import '../../../../core/utils/images.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/modal_pill.dart';
import '../../../widgets/pageview_toggler.dart';
import '../../loan/model/params/add_card_params.dart';
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

class DashboardLoanDueTime extends StatefulWidget {
  const DashboardLoanDueTime({Key? key}) : super(key: key);

  @override
  State<DashboardLoanDueTime> createState() => _DashboardLoanDueTimeState();
}

class _DashboardLoanDueTimeState extends State<DashboardLoanDueTime> {
  late Monnify? monnify;
  DateFormat dateFormat = DateFormat('MMM/yyyy');

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initMonnify();
    });

    super.initState();
  }

  _initMonnify() async {
    monnify = await Monnify.initialize(
      applicationMode: ApplicationMode.LIVE,
      apiKey: monnifyAPILiveKey,
      contractCode: contractKey,
    );
  }

  // void onInitializePayment({bool isFullPayment = true}) async {
  //   final paymentReference = DateTime.now().millisecondsSinceEpoch.toString();
  //   final user = context.read<AuthenticationProvider>().user;
  //   final loan = context.read<LoanProvider>();

  //   await loan
  //       .getLoanBalance(user!.loan!.settlingLoanApplicationId!)
  //       .catchError((_) => Exception('Could not get amount to be paid'));

  //   // Initia
  //   final transaction = TransactionDetails().copyWith(
  //     amount: double.parse(isFullPayment
  //         ? loan.loanBalanceResponse!.amount.toString()
  //         : loan.loanBalanceResponse!.pendingSchedules.first.amount),
  //     currencyCode: 'NGN',
  //     customerName: '${user.firstName} ${user.lastName}',
  //     customerEmail: user.email,
  //     paymentReference: paymentReference,
  //     paymentMethods: [
  //       PaymentMethod.CARD,
  //       PaymentMethod.ACCOUNT_TRANSFER,
  //       PaymentMethod.USSD,
  //       PaymentMethod.PHONE_NUMBER
  //     ],
  //     metaData: isFullPayment
  //         ? {
  //             'loanApplicationUniqueId': loan.loanBalanceResponse!.uniqueId,
  //             'floatrUserUniqueId': user.uniqueId!,
  //             'floatrUserName': '${user.firstName} ${user.lastName}',
  //             'date': DateTime.now().toIso8601String(),
  //             'reason': 'full_loan_payment',
  //           }
  //         : {
  //             'loanApplicationUniqueId': loan.loanBalanceResponse!.uniqueId,
  //             'paymentScheduleUniqueId':
  //                 loan.loanBalanceResponse!.pendingSchedules.first.uniqueId,
  //             'floatrUserUniqueId': user.uniqueId!,
  //             'floatrUserName': '${user.firstName} ${user.lastName}',
  //             'date': DateTime.now().toIso8601String(),
  //             'reason': 'part_loan_payment',
  //           },
  //   );

  //   try {
  //     final response =
  //         await monnify?.initializePayment(transaction: transaction);

  //     Fluttertoast.showToast(msg: response.toString());
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // NavigationService navigationService = di<NavigationService>();
    return Column(
      children: const [
        VerticalSpace(
          size: 20,
        ),
        LoanScheduleView(),
        // const VerticalSpace(
        //   size: 30,
        // ),
        // GeneralButton(
        //   height: 42,
        //   onPressed: () => onInitializePayment(),
        //   // onPressed: () => navigationService.navigateTo(
        //   //     RouteName.dashboardLoanDueTime,
        //   //     arguments: DashboardLoanDetailsArguments(
        //   //         dashboardLoanView: DashboardLoanView.loanDetailSchedule)),
        //   borderRadius: 8,
        //   isLoading:
        //       context.watch<LoanProvider>().loadingState == LoadingState.busy,
        //   child: const AppText(
        //     text: 'REPAY LOAN',
        //     color: Colors.white,
        //     fontWeight: FontWeight.w700,
        //   ),
        // ),
        // const VerticalSpace(
        //   size: 30,
        // ),
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
    return Consumer<LoanProvider>(
      builder: (context, loanProvider, _) {
        final loan = context.read<AuthenticationProvider>().user!.loan!;

        final loanId =
            loan.pendingLoanApplicationId ?? loan.settlingLoanApplicationId;

        switch (loanProvider.loadingState) {
          case LoadingState.busy:
            return Center(
              child: const CircularProgressIndicator.adaptive()
                  .paddingOnly(top: 30),
            );

          case LoadingState.error:
            return Center(
              child: Row(
                children: [
                  const AppText(
                    text: 'Could not get your loan!',
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    size: 15,
                  ),
                  InkWell(
                    onTap: () => loanProvider.getUserSubscribedLoan(loanId!),
                    child: const AppText(
                      text: ' Please try again.',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      size: 15,
                    ),
                  ),
                ],
              ),
            );

          case LoadingState.loaded:
            if (loanProvider.userSubscribedLoanResponse == null) {
              return SizedBox(
                height: context.heightPx * 0.7,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AppText(
                        text: 'Could not get your loan!',
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        size: 12,
                      ),
                      InkWell(
                        onTap: () =>
                            loanProvider.getUserSubscribedLoan(loanId!),
                        child: const AppText(
                          text: ' Please try again.',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Column(
              children: [
                InkWell(
                    onTap: () => setState(() {
                          togglePosition = toggle;
                        }),
                    child: PageViewToggler(
                      togglePosition: togglePosition,
                      viewName:  ['Details', loan.hasSettlingLoan! ? 'Payback Options' : 'Schedule'],
                    )),
                const VerticalSpace(
                  size: 24,
                ),
                togglePosition == TogglePosition.left
                    ? const LoanDetailsView()
                    : const LoanScheduleView()
              ],
            );

          default:
            return Container();
        }
      },
    );
  }

  TogglePosition get toggle => togglePosition == TogglePosition.left
      ? TogglePosition.right
      : TogglePosition.left;
}

class LoanScheduleView extends StatefulWidget {
  const LoanScheduleView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoanScheduleView> createState() => _LoanScheduleViewState();
}

class _LoanScheduleViewState extends State<LoanScheduleView> {
  late Monnify? monnify;
  DateFormat dateFormat = DateFormat('MMM/yyyy');
  NavigationService navigationService = di<NavigationService>();

  TextEditingController customAmountControlller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String loanAmount = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _initMonnify();
    });

    super.initState();
  }

  @override
  void dispose() {
    customAmountControlller.dispose();
    super.dispose();
  }

  _initMonnify() async {
    monnify = await Monnify.initialize(
      applicationMode: ApplicationMode.LIVE,
      apiKey: monnifyAPILiveKey,
      contractCode: contractKey,
    );
  }

  void onInitializePayment(
      {bool isFullPayment = true,
      Map<String, String>? customMetaData,
      TransactionDetails? customTransactionDetails}) async {
    final paymentReference = DateTime.now().millisecondsSinceEpoch.toString();
    final userProvider = context.read<AuthenticationProvider>();
    final loan = context.read<LoanProvider>();

    await loan
        .getLoanBalance(userProvider.user!.loan!.settlingLoanApplicationId!)
        .catchError((_) => Exception('Could not get amount to be paid'));

    // Initia
    final transaction = customTransactionDetails ??
        TransactionDetails().copyWith(
          amount: double.parse(isFullPayment
              ? loan.loanBalanceResponse!.amount.toString()
              : loan.loanBalanceResponse!.pendingSchedules.first.amount),
          currencyCode: 'NGN',
          customerName:
              '${userProvider.user!.firstName} ${userProvider.user!.lastName}',
          customerEmail: userProvider.user!.email,
          paymentReference: paymentReference,
          paymentMethods: [
            PaymentMethod.CARD,
            PaymentMethod.ACCOUNT_TRANSFER,
            PaymentMethod.USSD,
            PaymentMethod.PHONE_NUMBER
          ],
          metaData: customMetaData ??
              (isFullPayment
                  ? {
                      'loanApplicationUniqueId':
                          loan.loanBalanceResponse!.uniqueId,
                      'floatrUserUniqueId': userProvider.user!.uniqueId!,
                      'floatrUserName':
                          '${userProvider.user!.firstName} ${userProvider.user!.lastName}',
                      'date': DateTime.now().toIso8601String(),
                      'reason': 'full_loan_payment',
                    }
                  : {
                      'loanApplicationUniqueId':
                          loan.loanBalanceResponse!.uniqueId,
                      'paymentScheduleUniqueId': loan
                          .loanBalanceResponse!.pendingSchedules.first.uniqueId,
                      'floatrUserUniqueId': userProvider.user!.uniqueId!,
                      'floatrUserName':
                          '${userProvider.user!.firstName} ${userProvider.user!.lastName}',
                      'date': DateTime.now().toIso8601String(),
                      'reason': 'part_loan_payment',
                    }),
        );

    try {
      final response =
          await monnify?.initializePayment(transaction: transaction);
      loan.updateVerifyMonnifyParams(
          VerifyMonnifyParams(transactionRef: response!.transactionReference));

      // verify transaction
      loan.verifyMonnifyTransaction().then(
        (_) {
          if (loan.loadingState == LoadingState.loaded) {
            loan.getLoanBalance(
                userProvider.user!.loan!.settlingLoanApplicationId!);
            userProvider.getUser();
            if (isFullPayment) {
              navigationService.pushAndRemoveUntil(RouteName.navbar);
            }
          } else {
            loan.updateLoadingState(LoadingState
                .loaded); // force loading state to go back to loaded
          }
        },
      );

      Fluttertoast.showToast(msg: response.toString());
      log(response.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final userSubscribedLoan =
        context.read<LoanProvider>().userSubscribedLoanResponse;
    final user = context.read<AuthenticationProvider>().user;

    final loan = context.read<LoanProvider>();

    loan
        .getLoanBalance(user!.loan!.settlingLoanApplicationId!)
        .catchError((_) => Exception('Could not get amount to be paid'));

    // int weeks = (userSubscribedLoan!.maxTenureInDays / 7).floor();
    DateTime dateNowMinusOneDay =
        DateTime.now().subtract(const Duration(days: 0));

    log(userSubscribedLoan!.toJson().toString());

    final loanHasSchedules = userSubscribedLoan.paymentSchedules.isNotEmpty;

    Duration difference = loanHasSchedules
        ? userSubscribedLoan.paymentSchedules.first.dueDate!
            .difference(dateNowMinusOneDay)
        : userSubscribedLoan.dueDate.difference(dateNowMinusOneDay);

    int differenceInDays = (difference.inMilliseconds / 86400000).round() < 0
        ? 0
        : (difference.inMilliseconds / 86400000).round();

    // int differenceInDays = difference.inDays < 0 ? 0 : difference.inDays;
    // print(difference.inMilliseconds);
    return WillPopScope(
      onWillPop: () async {
        await context.read<AuthenticationProvider>().getUser();

        return true;
      },
      child: Column(
        children: [
          if (user.loan!.hasPendingApplication!) ...[
            Column(
              // child: Text(
              //   '''Your application is currently \npending approval!''',
              //   style: TextStyles.largeTextDarkPoppins,
              // ),

              children: [
                const VerticalSpace(
                  size: 50,
                ),
                Text(
                  '''Hi ${user.firstName},''',
                  style: TextStyles.normalTextDarkPoppins600,
                ),
                const VerticalSpace(
                  size: 20,
                ),
                Text(
                  '''There's no active schedule''',
                  style: TextStyles.normalTextDarkPoppins600,
                ),
                const VerticalSpace(
                  size: 10,
                ),
                Text(
                  '''becuase this loan is currently ''',
                  style: TextStyles.normalTextDarkPoppins600,
                ),
                const VerticalSpace(
                  size: 10,
                ),
              ],
            ),
            // pending approval

            if (userSubscribedLoan.status ==
                LoanAppLicationStatus.pendingApproval) ...[
              Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: ' pending approval!',
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const VerticalSpace(
                    size: 30,
                  ),
                  GeneralButton(
                    onPressed: () {},
                    width: 200,
                    height: 28,
                    borderRadius: 8,
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
                  )
                ],
              ),
            ]

            // pending disbursement
            else if (userSubscribedLoan.status ==
                LoanAppLicationStatus.pendingDisbursment) ...[
              Column(
                children: [
                  RichText(
                    text: const TextSpan(
                        text: ' pending disbursement!',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  const VerticalSpace(
                    size: 30,
                  ),
                  GeneralButton(
                    onPressed: () {},
                    width: 200,
                    height: 28,
                    borderRadius: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'VIEW DETAILS',
                          style: TextStyle(fontSize: 11.0),
                        ).paddingOnly(right: 10),
                        SvgPicture.asset(
                          'assets/icons/fill/arrow.svg',
                          height: 8,
                          width: 8,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ] else if (userSubscribedLoan.status ==
                LoanAppLicationStatus.approved) ...[
              Column(
                children: [
                  RichText(
                    text: const TextSpan(
                        text: ' approved but pending disbursement!',
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                  ),
                  const VerticalSpace(
                    size: 30,
                  ),
                  GeneralButton(
                    onPressed: () {},
                    width: 200,
                    height: 28,
                    borderRadius: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'VIEW DETAILS',
                          style: TextStyle(fontSize: 11.0),
                        ).paddingOnly(right: 10),
                        SvgPicture.asset(
                          'assets/icons/fill/arrow.svg',
                          height: 8,
                          width: 8,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ]

            // edge case
            else ...[
              RichText(
                text: const TextSpan(
                    text: ' pending!',
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ]

          // is settling - loan has disbursed
          else if (user.loan!.hasSettlingLoan! &&
              userSubscribedLoan.status == LoanAppLicationStatus.settling) ...[
            CircularPercentIndicator(
              radius: 110.0,
              backgroundColor: Colors.white,
              percent: (userSubscribedLoan.maxTenureInDays - differenceInDays) /
                  userSubscribedLoan.maxTenureInDays,
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

                  // overdue loan
                  if (differenceInDays <= 0) ...[
                    Text(
                      'Your current loan is',
                      style: TextStyles.smallTextDark,
                    ),
                    const VerticalSpace(size: 7),
                    RichText(
                      text: TextSpan(
                          text: 'Overdue!', style: TextStyles.largeTextPrimary),
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
                              style: TextStyles.largeTextPrimary),
                          // TextSpan(text: ' world!'),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),

            SizedBox(
              height:
                  userSubscribedLoan.paymentSchedules.length > 1 ? 275 : 155,
              child: ListView.separated(
                itemBuilder: (context, itemCount) => ScheduleListItem(
                  paymentSchedule:
                      userSubscribedLoan.paymentSchedules[itemCount],
                  isFirstSchedule: itemCount == 0,
                  onInitPay: () => onInitializePayment(
                      isFullPayment: userSubscribedLoan
                              .paymentSchedules.length ==
                          1), // if itemCount is 1 it automatically means we are making a single payment which can also imply a full payment
                ),
                separatorBuilder: (context, itemCount) => const VerticalSpace(
                  size: 20,
                ),
                itemCount: userSubscribedLoan.paymentSchedules.length,
              ),
            ),

            // const VerticalSpace(
            //   size: 20,
            // ),

            // Container(
            //   width: context.widthPx,
            //   height: 75,
            //   padding: const EdgeInsets.all(25),
            //   decoration: BoxDecoration(
            //       color: AppColors.lightGrey1,
            //       borderRadius: BorderRadius.circular(16)),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             dateFormat.format(userSubscribedLoan.dueDate),
            //             style: TextStyles.smallTextGrey14Px,
            //           ),
            //           Text(
            //             '₦${formatAmount(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!)}',
            //             style: TextStyles.normalTextDarkF800,
            //           ),
            //           Container(
            //             height: 21,
            //             width: 65,
            //             decoration: BoxDecoration(
            //                 color: AppColors.lightGreen,
            //                 borderRadius: BorderRadius.circular(30)),
            //             child: const Center(
            //               child: AppText(
            //                 text: 'Pending',
            //                 color: Colors.green,
            //                 size: 10,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),

            Container(
              height: 264,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              width: context.widthPx,
              decoration: BoxDecoration(
                color: AppColors.primaryColorLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "OTHER PAYBACK OPTIONS",
                    style: TextStyles.smallTextDark,
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => onInitializePayment(),
                        child: PaybackOption(
                          iconPath: SvgAppIcons.icClosePay,
                          optionPrompt: 'Close This Loan',
                          payOption:
                              'PAY ${formatAmount(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!)}',
                        ),
                      ),
                      InkWell(
                        onTap: () => AppDialog.showAppModal(
                          context,
                          Container(
                            height: 330,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            child: Column(
                              children: [
                                const VerticalSpace(
                                  size: 15,
                                ),
                                const ModalPill(),
                                const VerticalSpace(
                                  size: 62,
                                ),
                                Text(
                                  'How much would you like to pay now?',
                                  style: TextStyles.normalTextDarkF600,
                                ),
                                const VerticalSpace(size: 15),
                                Form(
                                  key: formKey,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  child: AppTextField(
                                    controller: customAmountControlller,
                                    hintText: 'Enter Amount',
                                    textInputType: TextInputType.number,
                                    validator: ((amount) {
                                      if (amount!.isEmpty) {
                                        return 'Amount field should not be empty';
                                      } else if (double.parse(amount) >
                                          loan.loanBalanceResponse!.amount) {
                                        return 'Amount exceeds loan balance';
                                      }
                                      return null;
                                    }),
                                    onSaved: (String? amount) =>
                                        loanAmount = amount!,
                                  ),
                                ),
                                const VerticalSpace(size: 40),
                                GeneralButton(
                                    onPressed: () {
                                      final bool isValid =
                                          formKey.currentState!.validate();

                                      if (isValid) {
                                        formKey.currentState!.save();
                                        onInitializePayment(
                                          customTransactionDetails:
                                              TransactionDetails().copyWith(
                                            amount: double.parse(loanAmount),
                                            currencyCode: 'NGN',
                                            customerName:
                                                '${user.firstName} ${user.lastName}',
                                            customerEmail: user.email,
                                            paymentReference: DateTime.now()
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            paymentMethods: [
                                              PaymentMethod.CARD,
                                              PaymentMethod.ACCOUNT_TRANSFER,
                                              PaymentMethod.USSD,
                                              PaymentMethod.PHONE_NUMBER
                                            ],
                                          ),
                                          customMetaData: {
                                            'loanApplicationUniqueId': loan
                                                .loanBalanceResponse!.uniqueId,
                                            'floatrUserUniqueId':
                                                user.uniqueId!,
                                            'floatrUserName':
                                                '${user.firstName} ${user.lastName}',
                                            'date': DateTime.now()
                                                .toIso8601String(),
                                            'reason': 'part_loan_payment',
                                          },
                                        );

                                        navigationService.pop(); // pop modal
                                        navigationService.pop(); // pop loan details
                                        navigationService.navigateTo(
                                            RouteName.dashboardLoanDueTime,
                                            arguments:
                                                DashboardLoanDetailsArguments(
                                                    dashboardLoanView:
                                                        DashboardLoanView
                                                            .loanDetailSchedule)); // navigate back to loan details
                                      }
                                    },
                                    child: const Text('MAKE PAYMENT'))
                              ],
                            ),
                          ),
                        ),
                        child: const PaybackOption(
                            iconPath: SvgAppIcons.icPartPay,
                            optionPrompt: 'Part Payment',
                            payOption: 'PAY ANY AMOUNT'),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // InkWell(
            //   onTap: () => onInitializePayment(),
            //   child: const Text(
            //     'REPAY ALL NOW',
            //     style: TextStyle(
            //       color: AppColors.primaryColor,
            //       fontSize: 14,
            //       fontWeight: FontWeight.w600,
            //       decoration: TextDecoration.underline,
            //     ),
            //   ),
            // ),

            const VerticalSpace(
              size: 50,
            ),

            // loan info box A
            // Container(
            //   height: 184,
            //   width: context.widthPx,
            //   padding: const EdgeInsets.all(18),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(16),
            //       color: AppColors.lightGrey1),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // principal
            // LoanSummaryRow(
            //   itemTitle: 'Principal',
            //   itemData:
            //       '₦${formatAmount(doubleStringToIntString(userSubscribedLoan.amount)!)}',
            // ),

            //       //interest
            //       LoanSummaryRow(
            //         itemTitle: 'Interest',
            //         itemData:
            //             '₦ ${formatAmount(percent(amount: int.parse(doubleStringToIntString(userSubscribedLoan.interestCharge)!), percentage: int.parse(doubleStringToIntString(userSubscribedLoan.amount)!)).toString())} (${formatAmount(doubleStringToIntString(userSubscribedLoan.interestCharge)!)}%) ',
            //       ),

            //       //platform
            //       LoanSummaryRow(
            //         itemTitle: 'Platform Fee',
            //         itemData:
            //             '₦ ${formatAmount(percent(amount: int.parse(doubleStringToIntString(userSubscribedLoan.platformCharge)!), percentage: int.parse(doubleStringToIntString(userSubscribedLoan.amount)!)).toString())} (${formatAmount(doubleStringToIntString(userSubscribedLoan.platformCharge)!)}%) ',
            //       ),

            //       // payback amount
            //       LoanSummaryRow(
            //         itemTitle: 'Payback Amount',
            //         itemData:
            //             '₦${formatAmount(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!)}',
            //       ),
            //     ],
            //   ),
            // ),

            // // loan info box B
            // const VerticalSpace(
            //   size: 18,
            // ),

            // // loan info box B
            // Container(
            //   height: 144,
            //   width: context.widthPx,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(16),
            //       color: AppColors.lightGrey1),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // loan tenure
            //       LoanSummaryRow(
            //         itemTitle: 'Loan Tenure',
            //         itemData: weeks == 1 ? '$weeks Week' : '$weeks Weeks',
            //       ),

            //       //No of Payments
            //       LoanSummaryRow(
            //         itemTitle: 'No of Payments',
            //         itemData:
            //             '$weeks * ₦${formatAmount((int.parse(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!) ~/ weeks).toString())}',
            //       ),

            //       //next payment
            //       LoanSummaryRow(
            //         itemTitle: 'Next Payment',
            //         itemData: dateFormat.format(userSubscribedLoan.dueDate),
            //       ),
            //     ],
            //   ),
            // ),

            // const VerticalSpace(
            //   size: 18,
            // ),

            // Container(
            //   height: 144,
            //   width: context.widthPx,
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(16),
            //       color: AppColors.lightGrey1),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // Ammount paid
            //       LoanSummaryRow(
            //         itemTitle: 'Amount Paid',
            //         itemData:
            //             '₦${formatAmount(doubleStringToIntString(userSubscribedLoan.totalPaidBackAmount)!)}',
            //       ),

            //       // Amount due
            //       LoanSummaryRow(
            //         itemTitle: 'Amount Due',
            //         itemData:
            //             '₦${formatAmount((int.parse(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!) - int.parse(doubleStringToIntString(userSubscribedLoan.totalPaidBackAmount)!)).toString())}', // subtract amount to pay - amount paid
            //       ),

            //       //due date
            //       LoanSummaryRow(
            //         itemTitle: 'Due Date',
            //         itemData: dateFormat.format(userSubscribedLoan.dueDate),
            //       ),
            //     ],
            //   ),
            // ),

            // const VerticalSpace(
            //   size: 30,
            // ),
          ],
        ],
      ),
    );
  }
}

class PaybackOption extends StatelessWidget {
  const PaybackOption({
    super.key,
    required this.iconPath,
    required this.optionPrompt,
    required this.payOption,
  });

  final String iconPath;
  final String optionPrompt;
  final String payOption;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158,
      width: 152,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(
            iconPath,
            // width: 46,
            // height: 46,
          ),
          Text(
            optionPrompt,
            style: TextStyles.normalTextDarkF800,
          ),
          Container(
            height: 26,
            width: 102,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                payOption,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ScheduleListItem extends StatelessWidget {
  const ScheduleListItem({
    super.key,
    required this.paymentSchedule,
    required this.isFirstSchedule,
    required this.onInitPay,
  });

  final PaymentSchedule paymentSchedule;
  final bool isFirstSchedule;
  final void Function() onInitPay;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMM yy');

    return Container(
      width: context.widthPx,
      height: isFirstSchedule ? 135 : 75,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          color: AppColors.lightGrey1, borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormat.format(paymentSchedule.dueDate!),
                style: TextStyles.smallTextGrey14Px,
              ),
              Text(
                '₦${formatAmount(doubleStringToIntString(paymentSchedule.amount)!)}',
                style: TextStyles.normalTextDarkF800,
              ),
              Container(
                height: 21,
                width: 65,
                decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: AppText(
                    text: paymentSchedule.status!,
                    color: Colors.green,
                    size: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          isFirstSchedule
              ? GeneralButton(
                  height: 40,
                  onPressed: onInitPay,
                  backgroundColor: Colors.black,
                  borderColor: Colors.black,
                  borderRadius: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       AppText(
                        size: 12,
                        text: 'PAY ${formatAmount(doubleStringToIntString(paymentSchedule.amount)!)} NOW',
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ).paddingOnly(right: 8),
                      SvgPicture.asset('assets/icons/fill/arrow.svg',
                          height: 8, width: 8),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

class LoanDetailsView extends StatelessWidget {
  const LoanDetailsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userSubscribedLoan =
        context.read<LoanProvider>().userSubscribedLoanResponse;

    final weeks = daysToWeeks(userSubscribedLoan!.tenureInDays);

    final amountSpilt = int.parse(
            doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!) ~/
        weeks;

    return SingleChildScrollView(
      child: Column(
        children: [
          // loan info box A
          Container(
            height: 260,
            width: context.widthPx,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.lightGrey1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // principal
                LoanSummaryRow(
                  itemTitle: 'Principal',
                  itemData:
                      'N${formatAmount(doubleStringToIntString(userSubscribedLoan.amount)!)}',
                ),

                // tenurw
                LoanSummaryRow(
                  itemTitle: 'Tenure',
                  itemData: '$weeks Week(s)',
                ),

                //interest
                LoanSummaryRow(
                  itemTitle: 'Interest',
                  itemData:
                      'N${formatAmount(percent(amount: int.parse(doubleStringToIntString(userSubscribedLoan.interestCharge)!), percentage: int.parse(doubleStringToIntString(userSubscribedLoan.amount)!)).toString())} (${formatAmount(doubleStringToIntString(userSubscribedLoan.interestCharge)!)}%) ',
                ),

                //platform
                LoanSummaryRow(
                  itemTitle: 'Platform Fee',
                  itemData:
                      'N${formatAmount(percent(amount: int.parse(doubleStringToIntString(userSubscribedLoan.platformCharge)!), percentage: int.parse(doubleStringToIntString(userSubscribedLoan.amount)!)).toString())} (${formatAmount(doubleStringToIntString(userSubscribedLoan.platformCharge)!)}%) ',
                ),

                // payback amount
                LoanSummaryRow(
                  itemTitle: 'Payback Amount',
                  itemData:
                      'N${formatAmount(doubleStringToIntString(userSubscribedLoan.totalPayBackAmount)!)}',
                ),

                // repayment cycle
                LoanSummaryRow(
                  itemTitle: 'Repayment Cycle(s)',
                  itemData: '$weeks * ${formatAmount(amountSpilt.toString())}',
                  titleTextStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  dataTextStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w900,
                  ),
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
                    onCardSelected: () {},
                    color: AppColors.primaryColorLight.withOpacity(0.25),
                    bankName: userSubscribedLoan.bank.bank.name,
                    bankNumber: userSubscribedLoan.bank.accountNo),
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
                              userSubscribedLoan.card.name,
                              style: TextStyles.smallTextDark14Px,
                            ),

                            const VerticalSpace(
                              size: 5,
                            ),

                            // bank num
                            Text(
                              '• • • •     • • • •    • • • •    ${userSubscribedLoan.card.panLast4}',
                              // style: TextStyles.smallTextGrey,
                              style: const TextStyle(
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

          const VerticalSpace(
            size: 40,
          ),

          GeneralButton(
            height: 40,
            width: 299,
            onPressed: () {},
            backgroundColor: Colors.black,
            borderColor: Colors.black,
            borderRadius: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                  size: 12,
                  text: 'VIEW SCHEDULE',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ).paddingOnly(right: 8),
                SvgPicture.asset('assets/icons/fill/arrow.svg',
                    height: 8, width: 8),
              ],
            ),
          )
        ],
      ),
    );
  }
}
