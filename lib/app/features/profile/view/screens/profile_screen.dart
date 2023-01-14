import 'dart:math' as math;
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/profile/view/screens/edit_profile.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../authentication/providers/authentication_provider.dart';
import '../widgets/account_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, provider, _) {
          final user = provider.user;

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
                          percent: .25,
                          lineWidth: 4,
                          animation: true,
                          progressColor: AppColors.primaryColor,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: CircleAvatar(
                            radius: 44,
                            backgroundImage: NetworkImage(user!.photo!.url!),
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
                  '${user.firstName} ${user.lastName}',
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                              SvgPicture.asset('assets/icons/outline/copy.svg'),
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
                                '${user.uniqueId!.substring(0, 10)}...',
                                style: TextStyles.smallTextDark,
                              ).paddingOnly(right: 5),
                              SvgPicture.asset('assets/icons/outline/copy.svg'),
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
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icTickCircleFill,
                          color: Colors.green,
                        ),
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
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icCaution,
                          // color: Colors.green,
                        ),
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
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icCaution,
                        ),
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
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icCaution,
                        ),
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
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icCaution,
                        ),
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
                  height: 210,
                  width: context.widthPx,
                  child: Column(
                    children: [
                      // biometric login
                      CustomProfileRow(
                        firstItem: SvgPicture.asset(
                          SvgAppIcons.icFingerprint,
                        ),
                        secondItem: Text(
                          'Biometric Login',
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
                      ),

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
                  onPressed: () {},
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
                  onTap: () =>
                      navigationService.navigateTo(RouteName.snapDocument),
                ),

                const VerticalSpace(size: 16),

                // NIN
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'National Identity Card',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () =>
                      navigationService.navigateTo(RouteName.snapDocument),
                ),

                const VerticalSpace(size: 16),

                // int passport
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'International Passport',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () =>
                      navigationService.navigateTo(RouteName.snapDocument),
                ),

                const VerticalSpace(size: 16),

                // voters card
                GovIDModalItem(
                  leadingIconPath: SvgAppIcons.icLicenseDriver,
                  itemTitle: 'Voter’s Card',
                  endIconPath: SvgAppIcons.icArrowRight,
                  onTap: () =>
                      navigationService.navigateTo(RouteName.snapDocument),
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
