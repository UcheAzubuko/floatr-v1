import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../../core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        image:
                            AssetImage('assets/images/profile-background.png'),
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
                      SvgPicture.asset(
                        SvgAppIcons.icEdit,
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
                      center: const CircleAvatar(radius: 44),
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
              'Adanna Erica',
              style: TextStyles.largeTextDark,
            ),

            // email
            Text(
              'me@gmail.com',
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
                            '+2348133459842',
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
                            '348133459842',
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
  }) : super(key: key);

  final Widget firstItem;
  final Widget secondItem;
  final Widget thirdItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        firstItem,
        const HorizontalSpace(size: 13),
        secondItem,
        const Spacer(),
        thirdItem
      ],
    ).paddingOnly(top: 20);
  }
}

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    Key? key,
    this.height = 149,
    this.width = 347,
    required this.infoTitle,
    required this.child,
  }) : super(key: key);

  final double height;
  final double width;
  final String infoTitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey300, width: 2),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            infoTitle,
            style: TextStyles.normalTextDarkF800,
          ).paddingSymmetric(horizontal: 16, vertical: 16),
          Container(
            // color: AppColors.black,
            height: 2,
            width: context.widthPx,
            decoration: const BoxDecoration(
              color: AppColors.lightGrey300,
            ),
          ),
          SizedBox(
              height: height - 58,
              child: child.paddingSymmetric(horizontal: 16)),
        ],
      ),
    );
  }
}