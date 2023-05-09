import 'dart:math' as math;
import 'package:clipboard/clipboard.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/data/model/response/user_repsonse.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/features/profile/data/model/params/change_password_params.dart';
import 'package:floatr/app/features/profile/data/model/user_helper.dart';
import 'package:floatr/app/features/profile/providers/user_profile_provider.dart';
import 'package:floatr/app/features/profile/view/screens/edit_profile.dart';
import 'package:floatr/app/features/profile/view/screens/profile_views/cards_banks_screen.dart';
import 'package:floatr/app/features/profile/view/screens/snap_document_screen.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/app/widgets/pageview_toggler.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/enums.dart';
import 'package:floatr/core/utils/extensions.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/providers/base_provider.dart';
import '../../../../../core/providers/biometric_provider.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../widgets/app_snackbar.dart';
import '../../../../widgets/custom_keyboard.dart';
import '../../../authentication/providers/authentication_provider.dart';
import '../../../dashboard/view/widgets/highlights_card.dart';
import '../widgets/account_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double _profileCompletionPercentage(UserResponse user) {
    final userHelper = UserHelper(user: user);
    double percent = 0.0;
    if (userHelper.isAddressComplete) {
      percent += 0.2;
    }
    if (userHelper.isEmployerDetailsComplete) {
      percent += 0.2;
    }
    if (userHelper.isPersonalDetailsComplete) {
      percent += 0.2;
    }
    if (userHelper.isNextOfKinComplete) {
      percent += 0.2;
    }
    if (user.idTypes!.isNotEmpty) {
      // percent += (user.idTypes!.length * 0.05); // chcck individual id
      // percent += 0.05;
    }

    return percent;
  }

  Widget _checkType({bool check = false, bool isPending = false}) {
    if (isPending && check == false) {
      return SvgPicture.asset(
        'assets/icons/outline/tick-circle-broken.svg',
        color: Colors.green,
      );
    } else if (check && isPending == false) {
      return SvgPicture.asset(
        SvgAppIcons.icTickCircleFill,
        color: Colors.green,
      );
    }
    return SvgPicture.asset(
      SvgAppIcons.icCaution,
      // color: Colors.green,
    );
  }

  late bool isBiometricActive;

  late bool isBiometricAvailable;

  late ChangePinParams _changePinParams;

  @override
  void initState() {
    final biometricProvider = context.read<BiometricProvider>();

    isBiometricAvailable =
        (biometricProvider.biometricType == BiometricType.face ||
            biometricProvider.biometricType == BiometricType.fingerprint);
    isBiometricActive =
        context.read<AuthenticationProvider>().isBiometricLoginEnabled;
    super.initState();

    _changePinParams = ChangePinParams();
  }

  _beginChangePin(TransactionPinState transPinState, {String? setInitialPin}) {
    final bool isInitial = transPinState == TransactionPinState.initial;
    // set tempPin as setInitialPin for comparison, if setInitial pin is null,
    // it therefore means there exists no other pin to compare with.
    String? tempPin = setInitialPin;
    bool isLoading = false;
    AppDialog.showAppDialog(
        context,
        ChangeNotifierProvider(
          create: (context) => KeyboardProvider()
            ..updateControllerActiveStatus(shouldDeactivateController: true)
            ..updateRequiredLength(6),
          child: Consumer<KeyboardProvider>(
            builder: (context, keyboard, _) {
              final userProfileProvider = context.read<UserProfileProvider>();
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
                                ? 'Enter Your Current Pin'
                                : 'Enter New Pin',
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
                    StatefulBuilder(builder: (context, setState) {
                      return GeneralButton(
                        height: 48,
                        width: 335,
                        borderColor: keyboard.isFilled
                            ? AppColors.primaryColor
                            : AppColors.primaryColorLight.withOpacity(0.1),
                        backgroundColor: keyboard.isFilled
                            ? AppColors.primaryColor
                            : AppColors.primaryColorLight.withOpacity(0.1),
                        borderRadius: 12,
                        isLoading: isLoading,
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
                                  _beginChangePin(TransactionPinState.confirm,
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
                                    if (tempPin == pin) {
                                      Fluttertoast.showToast(
                                          msg:
                                              'New pin should be different from old pin!',
                                          backgroundColor: Colors.red);
                                    } else {
                                      _changePinParams.pin = tempPin;
                                      _changePinParams.newPin = pin;

                                      userProfileProvider.updateChangePinParams(
                                          _changePinParams);

                                      // force loading
                                      setState(() => isLoading = true);

                                      await userProfileProvider
                                          .changePin()
                                          .then((_) {
                                        if (userProfileProvider.loadingState ==
                                            LoadingState.error) {
                                          di<NavigationService>()
                                              .pop(); // pop dialog
                                          AppSnackBar.showErrorSnackBar(context,
                                              userProfileProvider.errorMsg);
                                        } else if (userProfileProvider
                                                .loadingState ==
                                            LoadingState.loaded) {
                                          di<NavigationService>().pop();
                                          Fluttertoast.showToast(
                                              msg: 'Pin Changed Successfully',
                                              backgroundColor: Colors.blue);
                                        }
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
                      ).paddingOnly(left: 14, right: 14, bottom: 43);
                    }),
                  ],
                ),
              );
            },
          ),
        ),
        height: 541,
        width: 335);
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, provider, _) {
          final user = provider.user;
          final userHelper = UserHelper(user: user!);
          return SingleChildScrollView(
            child: Column(
              children: [
                const VerticalSpace(
                  size: 50,
                ),
                Stack(
                  alignment: const Alignment(0, 7.5),
                  children: [
                    Container(
                      height: 129,
                      padding: const EdgeInsets.all(16),
                      width: context.widthPx,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/profile-background.png'),
                            fit: BoxFit.fill),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Profile',
                            style: TextStyles.largeTextDark,
                          ),

                          // edit icon
                          InkWell(
                            onTap: () => navigationService.navigateToRoute(
                                const EditProfileScreen(
                                    editProfileView:
                                        EditProfile.personalDetails)),
                            child: SvgPicture.asset(
                              SvgAppIcons.icEdit,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 115,
                      width: 115,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 52,
                          backgroundColor: AppColors.lightGrey300,
                          percent: _profileCompletionPercentage(user),
                          lineWidth: 4,
                          animation: true,
                          progressColor: AppColors.primaryColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          animationDuration: 2000,
                          center: CircleAvatar(
                            radius: 44,
                            backgroundImage: NetworkImage(user.photo!.url!),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(
                  size: 42,
                ),

                // username
                Text(
                  '${user.firstName!.capitalizeFirstChar()} ${user.lastName!.capitalizeFirstChar()}',
                  style: TextStyles.largeTextDark,
                ),

                // email
                Text(
                  user.email!,
                  style: TextStyles.smallTextGrey,
                ),

                const VerticalSpace(size: 16),

                // profile completion status

                // account info card
                AccountInfoCard(
                  infoTitle: 'Account Information',
                  width: context.widthPx,
                  height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VerticalSpace(
                        size: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone',
                            style: TextStyles.smallTextGrey,
                          ),
                          Row(
                            children: [
                              Text(
                                user.phoneNumber!,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyles.smallTextDark,
                              ).paddingOnly(right: 5),
                              InkWell(
                                  onTap: () {
                                    FlutterClipboard.copy(user.phoneNumber!)
                                        .then((_) => Fluttertoast.showToast(
                                            msg:
                                                'Phone number copied to clipboard'));
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icons/outline/copy.svg')),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Customer ID',
                            style: TextStyles.smallTextGrey,
                          ),
                          Row(
                            children: [
                              Text(
                                '${user.uniqueId!.length > 10 ? user.uniqueId!.substring(0, 10) : user.uniqueId}...',
                                style: TextStyles.smallTextDark,
                              ).paddingOnly(right: 5),
                              InkWell(
                                  onTap: () {
                                    FlutterClipboard.copy(user.uniqueId!).then(
                                        (_) => Fluttertoast.showToast(
                                            msg:
                                                'Customer ID copied to clipboard'));
                                  },
                                  child: SvgPicture.asset(
                                      'assets/icons/outline/copy.svg')),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 16),

                // your data
                AccountInfoCard(
                  infoTitle: 'Your Data',
                  height: 299,
                  width: context.widthPx,
                  child: Column(
                    children: [
                      CustomProfileRow(
                        firstItem: _checkType(
                            check: userHelper.isPersonalDetailsComplete),
                        secondItem: Text(
                          'Personal Details',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateToRoute(
                            const EditProfileScreen(
                                editProfileView: EditProfile.personalDetails)),
                      ),

                      // gov-id
                      CustomProfileRow(
                        firstItem: _checkType(
                            // check: userHelper.isIdDataComplete ==
                            //     CriteriaState.done,
                            isPending: userHelper.isIdDataComplete ==
                                CriteriaState.pending),
                        secondItem: Text(
                          'Government Issued ID',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => AppDialog.showAppModal(context,
                            const GovIDModalView(), Colors.transparent),
                      ),

                      // address
                      CustomProfileRow(
                        firstItem:
                            _checkType(check: userHelper.isAddressComplete),
                        secondItem: Text(
                          'Residential Address',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateToRoute(
                            const EditProfileScreen(
                                editProfileView:
                                    EditProfile.residentialAddress)),
                      ),

                      // employment details
                      CustomProfileRow(
                        firstItem: _checkType(
                            check: userHelper.isEmployerDetailsComplete),
                        secondItem: Text(
                          'Employment Details',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateToRoute(
                            const EditProfileScreen(
                                editProfileView:
                                    EditProfile.employmentDetails)),
                      ),

                      // next of kin
                      CustomProfileRow(
                        firstItem:
                            _checkType(check: userHelper.isNextOfKinComplete),
                        secondItem: Text(
                          'Next of Kin',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateToRoute(
                            const EditProfileScreen(
                                editProfileView: EditProfile.nextOfKin)),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 16),

                // security
                AccountInfoCard(
                  infoTitle: 'Security',
                  height: isBiometricAvailable ? 230 : 168,
                  width: context.widthPx,
                  child: Column(
                    children: [
                      // biometric login
                      isBiometricAvailable
                          ? CustomProfileRow(
                              firstItem: SvgPicture.asset(
                                SvgAppIcons.icFingerprint,
                              ),
                              secondItem: Text(
                                'Biometric Login',
                                style: TextStyles.smallTextDark14Px,
                              ),
                              thirdItem: CupertinoSwitch(
                                  value: isBiometricActive,
                                  activeColor: AppColors.primaryColor,
                                  onChanged: (isEnabled) {
                                    setState(() {
                                      isBiometricActive = isEnabled;
                                      provider.setBiometricLogin(isEnabled);
                                    });
                                    // provider.setBiometricLogin(isEnabled);
                                  }),
                            )
                          : const SizedBox(),

                      // change password
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icLock3Dots,
                        ),
                        secondItem: Text(
                          'Change Password',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService
                            .navigateTo(RouteName.changePasswordScreen),
                      ).paddingOnly(bottom: 7),

                      // change transaction pin
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icKey,
                        ),
                        secondItem: Text(
                          'Change Transaction Pin',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () =>
                            _beginChangePin(TransactionPinState.initial),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 16),

                // cards and banks cards
                AccountInfoCard(
                  infoTitle: 'Cards & Banks',
                  height: 161,
                  width: context.widthPx,
                  child: Column(
                    children: [
                      //  cards
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icCards,
                        ),
                        secondItem: Text(
                          'Cards',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateTo(
                            RouteName.cardsBanks,
                            arguments: CardsBanksArguments(
                                bottomScreenName: 'Profile',
                                togglePosition: TogglePosition.left)),
                      ),

                      // banks
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icSecurityCard,
                        ),
                        secondItem: Text(
                          'Banks',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                        onTap: () => navigationService.navigateTo(
                            RouteName.cardsBanks,
                            arguments: CardsBanksArguments(
                                bottomScreenName: 'Profile',
                                togglePosition: TogglePosition.right)),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 16),

                // help centre cards
                AccountInfoCard(
                  infoTitle: 'Help Centre',
                  height: 260,
                  width: context.widthPx,
                  child: Column(
                    children: [
                      // guides faq
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icLampOn,
                        ),
                        secondItem: Text(
                          'Guide & FAQs',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                      ),

                      // contact floatr
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icMessageQuestion,
                        ),
                        secondItem: Text(
                          'Contact Floatr',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                      ),

                      // t and c
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icClipboardText,
                        ),
                        secondItem: Text(
                          'Terms and Conditions',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          'assets/icons/outline/arrow-right.svg',
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                      ),

                      // privacy
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icSecurityUser,
                        ),
                        secondItem: Text(
                          'Privacy Policy',
                          style: TextStyles.smallTextDark14Px,
                        ),
                        thirdItem: SvgPicture.asset(
                          SvgAppIcons.icArrowRight,
                          color: Colors.black,
                          fit: BoxFit.scaleDown,
                          height: 20,
                          width: 6,
                        ),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 32),

                // logout button
                GeneralButton(
                  height: 52,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.red,
                  onPressed: () {
                    Provider.of<LoanProvider>(context, listen: false)
                      ..myCardsResponse!.cards.clear()
                      ..myBanksResponse!.mybanks.clear();

                    return provider.logout();
                  },
                  // onPressed: () => showDialog(
                  //     context: context,
                  //     barrierDismissible: true,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: const Text('Logging Out?'),
                  //         content: SingleChildScrollView(
                  //           child: ListBody(
                  //             children: const <Widget>[
                  //               Text('Are you sure you want to log out?'),
                  //             ],
                  //           ),
                  //         ),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             child: Text(
                  //               'CONFIRM',
                  //               style: TextStyles.smallTextPrimary,
                  //             ),
                  //             onPressed: () => provider.logout(),
                  //           ),
                  //           TextButton(
                  //             child: Text(
                  //               'CANCEL',
                  //               style: TextStyles.smallTextPrimary,
                  //             ),
                  //             onPressed: () => navigationService.pop(),
                  //           ),
                  //         ],
                  //       );
                  //     }),
                  borderRadius: 12,
                  child: const AppText(
                    size: 14,
                    text: 'LOG OUT',
                    color: AppColors.red,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const VerticalSpace(size: 32),
              ],
            ).paddingSymmetric(horizontal: 7),
          );
        },
      ),
    );
  }
}

class GovIDModalView extends StatelessWidget {
  const GovIDModalView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();
    return CustomPaint(
      size: Size(
          context.widthPx, (context.widthPx * 1.2833333333333334).toDouble()),
      painter: ModalTipPainter(),
      child: Stack(
        alignment: const Alignment(0, -0.95),
        children: [
          const MyArc(
            diameter: 30,
          ),
          Container(
            height: 491,
            color: Colors.transparent,
            padding: const EdgeInsets.only(left: 24.5, right: 24.5, top: 60),
            child: ListView(
              children: [
                Center(
                  child: Text(
                    'Which Official ID whould you like to use?',
                    style: TextStyles.smallTextDark14Px,
                  ),
                ),

                const VerticalSpace(size: 16),

                // drivers license
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'Driver\'s License',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () {
                    navigationService.pop(); // pop modal first
                    navigationService.navigateTo(RouteName.snapDocument,
                        arguments: SnapDocumentArguments(
                            documentType: DocumentType.driverLicense));
                  },
                ),

                const VerticalSpace(size: 16),

                // NIN
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'National Identity Card',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () => navigationService.navigateTo(
                      RouteName.snapDocument,
                      arguments: SnapDocumentArguments(
                          documentType: DocumentType.nationalIdentityCard)),
                ),

                const VerticalSpace(size: 16),

                // int passport
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'International Passport',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () => navigationService.navigateTo(
                    RouteName.snapDocument,
                    arguments: SnapDocumentArguments(
                        documentType: DocumentType.internationalPassport),
                  ),
                ),

                const VerticalSpace(size: 16),

                // voters card
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'Voter’s Card',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () => navigationService.navigateTo(
                      RouteName.snapDocument,
                      arguments: SnapDocumentArguments(
                          documentType: DocumentType.votersCard)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({super.key, this.diameter = 200});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyArcPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = AppColors.lightGrey300.withOpacity(0.8);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: (size.width) * 2,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GovIDModalItem extends StatelessWidget {
  const GovIDModalItem({
    Key? key,
    required this.leadingIconPath,
    required this.itemTitle,
    required this.endIconPath,
    this.onTap,
  }) : super(key: key);

  final String leadingIconPath;
  final String itemTitle;
  final String endIconPath;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        decoration: BoxDecoration(
            color: AppColors.lightGrey300,
            borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SvgPicture.asset(leadingIconPath),
            const HorizontalSpace(size: 13),
            Text(
              itemTitle,
              style: TextStyles.normalTextDarkF500,
            ),
            const Spacer(),
            SvgPicture.asset(
              endIconPath,
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProfileRow extends StatelessWidget {
  const CustomProfileRow({
    Key? key,
    required this.firstItem,
    required this.secondItem,
    required this.thirdItem,
    this.onTap,
  }) : super(key: key);

  final Widget firstItem;
  final Widget secondItem;
  final Widget thirdItem;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          firstItem,
          const HorizontalSpace(size: 13),
          secondItem,
          const Spacer(),
          thirdItem
        ],
      ).paddingOnly(top: 20),
    );
  }
}

// import 'dart:ui' as ui;

//Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size: Size(WIDTH, (WIDTH*1.2833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter: RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class ModalTipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5492194, size.height * 0.007617013);
    path_0.cubicTo(
        size.width * 0.5161944,
        size.height * -0.00002502965,
        size.width * 0.4810278,
        size.height * -0.00002502641,
        size.width * 0.4480028,
        size.height * 0.007617013);
    path_0.lineTo(size.width * 0.2904333, size.height * 0.04407749);
    path_0.lineTo(size.width * 0.08888889, size.height * 0.04407749);
    path_0.cubicTo(
        size.width * 0.04698639,
        size.height * 0.04407749,
        size.width * 0.02603494,
        size.height * 0.04407749,
        size.width * 0.01301747,
        size.height * 0.05422100);
    path_0.cubicTo(0, size.height * 0.06436450, 0, size.height * 0.08069026, 0,
        size.height * 0.1133416);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(size.width, size.height * 0.1133416);
    path_0.cubicTo(
        size.width,
        size.height * 0.08069026,
        size.width,
        size.height * 0.06436450,
        size.width * 0.9869833,
        size.height * 0.05422100);
    path_0.cubicTo(
        size.width * 0.9739639,
        size.height * 0.04407749,
        size.width * 0.9530139,
        size.height * 0.04407749,
        size.width * 0.9111111,
        size.height * 0.04407749);
    path_0.lineTo(size.width * 0.7067889, size.height * 0.04407749);
    path_0.lineTo(size.width * 0.5492194, size.height * 0.007617013);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
