import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final NavigationService navigationService = di<NavigationService>();

  DateTime? dateOfBirth;

  TextEditingController dateController = TextEditingController();

  DateFormat dateFormat = DateFormat('dd MMM,yyyy');

  void _datePicker() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    setState(() {
      dateOfBirth = date!;
    });
    dateController.text = dateFormat.format(date!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // getstarted
              AppText(
                text: 'Getting Started',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.089,
              ),

              // sub text
              AppText(
                text: 'Create an account to continue!',
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 30),

              // email text and textfield
              AppText(
                text: 'Email Address',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                hintText: 'jen@floatr.com',
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.unspecified,
              ),

              const VerticalSpace(size: 10),

              // phone number text and textfield
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Phone number ',
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    size: context.widthPx * 0.035,
                  ),
                  AppText(
                    text: '(Linked with BVN)',
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    size: context.widthPx * 0.035,
                  ),
                ],
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(context.diagonalPx * 0.01),
                    child: SizedBox(
                      child: SvgPicture.asset(
                        'assets/icons/fill/nigeria-flag.svg',
                      ),
                    ),
                  ),
                  hintText: '+234 813 123 4567',
                  controller: TextEditingController(),
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.unspecified),

              // password text and textfield
              const VerticalSpace(size: 10),

              AppText(
                text: 'Password',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                hintText: 'Password',
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.unspecified,
              ),

              // confirm password text and textfield
              const VerticalSpace(size: 10),

              AppText(
                text: 'Confirm Password',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                hintText: 'Passwords must match',
                controller: TextEditingController(),
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.unspecified,
              ),

              const VerticalSpace(size: 10),

              // dob text and textfield
              AppText(
                text: 'Date of Birth',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                prefixIcon: Padding(
                  padding: EdgeInsets.all(context.diagonalPx * 0.01),
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/icons/fill/calendar.svg',
                      color: AppColors.grey,
                    ),
                  ),
                ),
                onTap: _datePicker,
                controller: dateController,
                hintText: 'DD-MM-YYYY',
                readOnly: true,
              ),

              const VerticalSpace(size: 30),

              Container(
                padding: EdgeInsets.only(
                  bottom: context.heightPx * 0.0006,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.gunMetal,
                      width: context.widthPx * 0.001,
                    ),
                  ),
                ),
                child: AppText(
                  text: 'Have a referral code?',
                  color: AppColors.gunMetal,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.031,
                ),
              ),

              const VerticalSpace(size: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0,
                    width: 20,
                    child: Checkbox(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      value: false,
                      onChanged: (_) {},
                    ),
                  ),
                  const HorizontalSpace(size: 10),
                  Row(
                    children: [
                      AppText(
                        text: 'I accept and agree all to all ',
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        size: context.widthPx * 0.031,
                      ),
                      AppText(
                        text: 'terms and conditions',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        size: context.widthPx * 0.031,
                      ),
                    ],
                  ),
                ],
              ),

              const VerticalSpace(size: 20),

              GeneralButton(
                onPressed: () =>
                    navigationService.navigateTo(RouteName.verifyOTP),
                buttonTextColor: Colors.white,
                child: const Text('Next'),
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: context.widthPx * 0.037),
      ),
    );
  }
}
