import 'dart:developer';

import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/loan/model/params/add_card_params.dart';
import 'package:floatr/app/features/loan/model/params/verify_bank_params.dart';
import 'package:floatr/app/features/loan/model/responses/card_response.dart'
    as cardResponse;
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:floatr/app/widgets/prompt_widget.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:monnify_payment_sdk/monnify_payment_sdk.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/secrets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/general_button.dart';
import '../../../../widgets/text_field.dart';
import '../../model/responses/banks_response.dart';

class LoanApplicationInformationBaseView extends StatelessWidget {
  const LoanApplicationInformationBaseView(
      {super.key, required this.child, this.applyCustomAppBar = true});

  final Widget child;
  final bool applyCustomAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Loan Application',
          useInAppArrow: true,
          shrinkAppBar: !applyCustomAppBar,
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
                navigationService.navigateToRoute(const SelectCardScreen(
              showAppBar: true,
            )),
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
            height: 230,
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
                navigationService.navigateToRoute(const SelectBankScreen()),
            borderRadius: 8,
            child: const AppText(
              text: 'CONTINUE',
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ).paddingOnly(bottom: 30)
        ],
      ),
    );
  }
}

class SelectCardScreen extends StatefulWidget {
  const SelectCardScreen({Key? key, this.showAppBar = false}) : super(key: key);

  final bool showAppBar;

  @override
  State<SelectCardScreen> createState() => _SelectCardScreenState();
}

class _SelectCardScreenState extends State<SelectCardScreen> {
  late Monnify? monnify;
  DateFormat dateFormat = DateFormat('MMM/yyyy');

  @override
  void initState() {
    _initMonnify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoanApplicationInformationBaseView(
      applyCustomAppBar: widget.showAppBar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.showAppBar
              ? const VerticalSpace(
                  size: 25,
                )
              : const SizedBox(),

          // title
          Text(
            'Select Card',
            style: TextStyles.largeTextDark,
          ),

          const VerticalSpace(
            size: 9,
          ),

          Text(
            'Which card would you like us to use for your \nrepayment?',
            style: TextStyles.smallTextGrey14Px,
          ),

          const VerticalSpace(
            size: 25,
          ),

          // const Spacer(),
          Column(
            children: [
              SizedBox(
                height: context.heightPx * 0.55,
                child:
                    Consumer<LoanProvider>(builder: (context, loanProvider, _) {
                  final cards = loanProvider.myCardsResponse == null
                      ? []
                      : loanProvider.myCardsResponse!.cards;
                  switch (loanProvider.loadingState) {
                    case LoadingState.busy:
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    case LoadingState.loaded:
                      if (cards.isEmpty) {
                        return Center(
                          child: Text(
                            '''You have not added any cards yet!''',
                            style: TextStyles.normalTextDarkF800,
                          ),
                        );
                      }

                      return ListView.builder(
                          itemCount: cards.length,
                          itemBuilder: (context, index) => DebitCard(
                                card: cards[index],
                              ).paddingOnly(bottom: 20));

                    default:
                      return Center(
                        child: Text(
                          '''An Unexpected error occured!''',
                          style: TextStyles.normalTextDarkF800,
                        ),
                      );
                  }
                  // children: [
                  //     const DebitCard(),
                  //     const VerticalSpace(
                  //       size: 35,
                  //     ),
                  //     InkWell(
                  //       onTap: onInitializePayment,
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: const [
                  //           // plus
                  //           CircleAvatar(
                  //             radius: 18,
                  //             backgroundColor: AppColors.primaryColor,
                  //             child: Icon(
                  //               Icons.add,
                  //               color: Colors.white,
                  //             ),
                  //           ),

                  //           HorizontalSpace(
                  //             size: 8,
                  //           ),

                  //           // add new bank
                  //           Text(
                  //             'ADD NEW CARD',
                  //             style: TextStyle(
                  //                 fontSize: 14,
                  //                 fontWeight: FontWeight.w700,
                  //                 color: AppColors.primaryColor),
                  //           ),
                  //         ],
                  //       ),
                  //     ).paddingOnly(bottom: 30)
                  //   ],
                }),
              ),
              const VerticalSpace(
                size: 35,
              ),
              InkWell(
                onTap: onInitializePayment,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // plus
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primaryColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),

                    HorizontalSpace(
                      size: 8,
                    ),

                    // add new bank
                    Text(
                      'ADD NEW CARD',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 30)
            ],
          )
        ],
      ),
    );
  }

  _initMonnify() async {
    monnify = await Monnify.initialize(
      applicationMode: ApplicationMode.LIVE,
      apiKey: monnifyAPILiveKey,
      contractCode: contractKey,
    );
  }

  void onInitializePayment() async {
    final paymentReference = DateTime.now().millisecondsSinceEpoch.toString();
    final user = context.read<AuthenticationProvider>().user;
    final loan = context.read<LoanProvider>();

    // Initia
    final transaction = TransactionDetails().copyWith(
      amount: 100,
      currencyCode: 'NGN',
      customerName: '${user!.firstName} ${user.lastName}',
      customerEmail: 'customer@floatr.com',
      paymentReference: paymentReference,
      paymentMethods: [PaymentMethod.CARD],
      metaData: {
        'floatrUserUniqueId': user.uniqueId!,
        'floatrUserName': '${user.firstName} ${user.lastName}',
        'date': DateTime.now().toIso8601String(),
        'reason': 'add_user_card',
      },
    );

    try {
      final response =
          await monnify?.initializePayment(transaction: transaction);

      loan.updateAddCardParams(
          AddCardParams(transactionRef: response!.transactionReference));
      loan.addCard().then((_) {
        if (loan.loadingState == LoadingState.loaded) {
          loan.getMyCards();
        } else {
          loan.updateLoadingState(
              LoadingState.loaded); // force loading state to go back to loaded
        }
      });

      Fluttertoast.showToast(msg: response.toString());
      log(response.toString());
    } catch (e) {
      log('$e');
      Fluttertoast.showToast(msg: e.toString());
    }
  }
}

class DebitCard extends StatelessWidget {
  const DebitCard({
    Key? key,
    required this.card,
  }) : super(key: key);
  final cardResponse.Card card;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('MM/yy');
    return Stack(
      children: [
        Container(
          height: 194,
          width: context.widthPx,
          decoration: BoxDecoration(
              color: AppColors.card, borderRadius: BorderRadius.circular(16)),
        ),
        SvgPicture.asset(
          height: 194,
          width: context.widthPx,
          SvgImages.debitCardBackground,
          color: AppColors.primaryColor,
          fit: BoxFit.contain,
          clipBehavior: Clip.hardEdge,
        ),
        Container(
          height: 194,
          width: context.widthPx,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: SvgPicture.asset(
                  SvgImages.cardTypeVisa,
                ),
              ),
              const VerticalSpace(
                size: 50,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    SvgImages.chip,
                  ),
                  const Spacer(),
                  Text(
                    '●●●● ●●●● ●●●● ${card.maskedPan.substring(card.maskedPan.length - 4)}',
                    style: const TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        wordSpacing: 3,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    card.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    dateFormat.format(card.expiryDate),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SelectBankScreen extends StatelessWidget {
  const SelectBankScreen({Key? key}) : super(key: key);

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
            'Select Bank',
            style: TextStyles.largeTextDark,
          ),

          const VerticalSpace(
            size: 9,
          ),

          Text(
            'Which bank would you like us to send the funds \nto?',
            style: TextStyles.smallTextGrey14Px,
          ),

          const VerticalSpace(
            size: 29,
          ),

          SizedBox(
            height: context.heightPx * 0.4,
            child: Consumer<LoanProvider>(
              builder: (context, loanProvider, _) {
                final banks = loanProvider.myBanksResponse == null
                    ? []
                    : loanProvider.myBanksResponse!.mybanks;
                switch (loanProvider.loadingState) {
                  case LoadingState.busy:
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  case LoadingState.loaded:
                    if (banks.isEmpty) {
                      return Center(
                        child: Text(
                          '''You have not added any accounts yet!.''',
                          style: TextStyles.normalTextDarkF800,
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: banks.length,
                        itemBuilder: (context, index) => SelectBank(
                              color: AppColors.lightGrey300,
                              bankName: banks[index].bank.name,
                              bankNumber: banks[index].accountNo,
                              isDefault: banks[index].isDefault,
                            ).paddingOnly(bottom: 20));
                  case LoadingState.error:
                    return Center(
                      child: Text(
                        '''An Unexpected error occured!''',
                        style: TextStyles.normalTextDarkF800,
                      ),
                    );

                  default:
                    return Center(
                      child: Text(
                        '''An Unexpected error occured!''',
                        style: TextStyles.normalTextDarkF800,
                      ),
                    );
                }
              },
            ),
          ),

          InkWell(
            onTap: () =>
                navigationService.navigateToRoute(const AddNewBankScreen()),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                // plus
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primaryColor,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),

                HorizontalSpace(
                  size: 8,
                ),

                // add new bank
                Text(
                  'ADD NEW BANK',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ).paddingOnly(bottom: 30)
        ],
      ),
    );
  }
}

class SelectBank extends StatelessWidget {
  const SelectBank(
      {Key? key,
      required this.color,
      required this.bankName,
      required this.bankNumber,
      this.isDefault = false})
      : super(key: key);

  final Color color;
  final String bankName;
  final String bankNumber;
  final bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: context.widthPx,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // image and container
          SizedBox.square(
            dimension: 42,
            child: Image.asset(
              AppImages.bankBuilding,
            ),
          ),

          const HorizontalSpace(
            size: 16,
          ),

          // bank name and number column
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // bank name
              Text(
                bankName,
                style: TextStyles.smallTextDark14Px,
              ),

              const VerticalSpace(
                size: 5,
              ),

              // bank num
              Text(
                bankNumber,
                style: TextStyles.smallTextGrey,
              )
            ],
          ),

          const Spacer(),

          // show default
          isDefault
              ? Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 60,
                    height: 21,
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackground,
                        borderRadius: BorderRadius.circular(8)),
                    child: const Center(
                        child: Text(
                      'Default',
                      style: TextStyle(fontSize: 10),
                    )),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

class AddNewBankScreen extends StatelessWidget {
  const AddNewBankScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    BankParams? bankParams =
        BankParams(bankAccountNumber: '', bankId: '', processor: 'monnify');

    Bank? selectedBank;
    TextEditingController accountNameController = TextEditingController();

    return LoanApplicationInformationBaseView(
      child: ChangeNotifierProvider(
        create: (context) => LoanProvider(loansRepository: di())..getBanks(),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Builder(builder: (context) {
            final loan = context.watch<LoanProvider>();
            return Column(
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
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
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

                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Selector<LoanProvider, BanksResponse>(
                      selector: ((_, provider) =>
                          provider.banksResponse ??
                          BanksResponse(
                              banks: [Bank(id: '0', name: 'Loading...')])),
                      builder: (context, bankResponse, __) {
                        return DropdownButtonFormField<Bank>(
                          decoration: const InputDecoration.collapsed(
                              hintText: 'Select Bank',
                              hintStyle: TextStyle(
                                  color: AppColors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                          // value: ,
                          focusColor: AppColors.black,

                          borderRadius: BorderRadius.circular(12),
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                          isExpanded: true,
                          items: bankResponse.banks
                              .map(
                                (Bank bank) => DropdownMenuItem<Bank>(
                                  value: bank,
                                  child: AppText(
                                    text: bank.name,
                                    fontWeight: FontWeight.w500,
                                    size: 12,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (Bank? bank) {
                            selectedBank = bank!;
                            bankParams.bankId = bank.id;
                          },
                          value: selectedBank,
                          onSaved: (Bank? bank) {},
                        );
                      },
                    ),
                  ),
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
                  controller: accountNameController,
                  hintText: 'Enter your Account number',
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  validator: (value) {
                    if (value!.length < 10) {
                      return 'Account Number not valid';
                    }
                    return null;
                    // return '';
                  },
                  onChanged: (value) async {
                    if (value!.length == 10) {
                      bankParams.bankAccountNumber = value;
                      context.read<LoanProvider>()
                        ..updateBankParams(bankParams)
                        ..verifyAccount();
                    }
                  },
                ),
                //

                const VerticalSpace(
                  size: 32,
                ),

                //
                Text(
                  'Account Name',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),

                Text(
                  loan.verifyBankResponse == null
                      ? ''
                      : loan.verifyBankResponse!.accountName.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold),
                ),

                const VerticalSpace(
                  size: 194,
                ),

                GeneralButton(
                  height: 42,
                  isLoading: loan.loadingState == LoadingState.busy,
                  onPressed: () => loan.verifyBankResponse != null
                      ? _handleAddBank(loan, context)
                      : null,
                  // ? navigationService
                  //     .navigateToRoute(const LoanSummaryScreen())
                  // : null,
                  borderRadius: 8,
                  backgroundColor: loan.verifyBankResponse != null
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight,
                  borderColor: loan.verifyBankResponse != null
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight,
                  child: const AppText(
                    text: 'CONTINUE',
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ).paddingOnly(bottom: 30)
              ],
            );
          }),
        ),
      ),
    );
  }

  _handleAddBank(LoanProvider provider, context) async {
    final bankDetails = provider.bankParams;
    final bankName = provider.verifyBankResponse!.accountName;
    provider.updateAddBankParams(AddBankParams(
        accountNo: bankDetails!.bankAccountNumber,
        bankId: bankDetails.bankId,
        processor: bankDetails.processor,
        accountName: bankName!));
    await provider.addBank();
    if (provider.loadingState == LoadingState.error) {
      AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
    }
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

            const VerticalSpace(
              size: 38,
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

            // bank and card
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

class LoanSummaryRow extends StatelessWidget {
  const LoanSummaryRow({
    Key? key,
    required this.itemData,
    required this.itemTitle,
  }) : super(key: key);
  final String itemTitle;
  final String itemData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          itemTitle,
          style: TextStyles.smallTextGrey14Px,
        ),
        Text(
          itemData,
          style: TextStyles.normalTextDarkPoppins,
        ),
      ],
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
            ).paddingOnly(bottom: 30),
          ],
        ),
      ),
    );
  }
}

class NavBarCardScreen extends StatelessWidget {
  const NavBarCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                height: 230,
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
                    navigationService.navigateToRoute(const SelectBankScreen()),
                borderRadius: 8,
                child: const AppText(
                  text: 'CONTINUE',
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ).paddingOnly(bottom: 30)
            ],
          ),
        ),
      ),
    );
  }
}
