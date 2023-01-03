import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/extensions/validator_extension.dart';
import 'package:floatr/app/features/authentication/data/model/params/register_params.dart';
import 'package:floatr/app/widgets/disabled_button.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../providers/authentication_provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final NavigationService navigationService = di<NavigationService>();

  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();

  DateTime? dateOfBirth;
  bool? acceptedTC = false;

  TextEditingController dateController = TextEditingController();

  final _fullnameValidator =
      ValidationBuilder().fullname().maxLength(20).build();
  final _emailValidator = ValidationBuilder().email().maxLength(50).build();
  final _passwordValidator = ValidationBuilder().password().build();
  final _phoneValidator = ValidationBuilder().phone().build();

  DateFormat dateFormat = DateFormat('yyyy-MMM-dd');

  late RegisterParams _registerParams;

  final _formKey = GlobalKey<FormState>();

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

  // void _toggleTC(value) {
  //   setState(() {
  //     acceptedTC = value;
  //   });
  // }
  @override
  void initState() {
    _registerParams = RegisterParams(
        email: null,
        password: null,
        name: null,
        phoneNumber: null,
        dateOfBirth: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  text: 'Full Name',
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.035,
                ),

                const VerticalSpace(size: 10),

                AppTextField(
                  hintText: 'ex. James Okoro',
                  controller: fullNameController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified,
                  onSaved: (String? name) => _registerParams.name = name!,
                  validator: _fullnameValidator,
                ),

                const VerticalSpace(size: 10),

                // email text and textfield
                const AppText(
                  text: 'Email Address',
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: 12,
                ),

                const VerticalSpace(size: 10),

                AppTextField(
                  hintText: 'jen@floatr.com',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified,
                  onSaved: (String? email) => _registerParams.email = email!,
                  validator: _emailValidator,
                ),

                const VerticalSpace(size: 10),

                // phone number text and textfield
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    AppText(
                      text: 'Phone number ',
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      size: 12,
                    ),
                    AppText(
                      text: '(Linked with BVN)',
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      size: 12,
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
                  controller: phoneNumberController,
                  textInputType: TextInputType.phone,
                  textInputAction: TextInputAction.unspecified,
                  onSaved: (String? number) =>
                      _registerParams.phoneNumber = number!,
                  validator: _phoneValidator,
                ),

                // password text and textfield
                const VerticalSpace(size: 10),

                const AppText(
                  text: 'Password',
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: 12,
                ),

                const VerticalSpace(size: 10),

                AppTextField(
                  hintText: 'Password',
                  controller: passwordController,
                  textInputType: TextInputType.emailAddress,
                  obscureText: true,
                  textInputAction: TextInputAction.unspecified,
                  onSaved: (String? password) =>
                      _registerParams.password = password,
                  validator: _passwordValidator,
                ),

                // confirm password text and textfield
                const VerticalSpace(size: 10),

                const AppText(
                  text: 'Confirm Password',
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: 12,
                ),

                const VerticalSpace(size: 10),

                AppTextField(
                  hintText: 'Passwords must match',
                  controller: confirmPasswordController,
                  obscureText: true,
                  textInputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.unspecified,
                  // onSaved: (String? password) => _registerParams.password = password,
                  validator: (password) {
                    if (passwordController.text != password) {
                      return 'Both Passwords are not similar.';
                    }
                    return null;
                  },
                ),

                const VerticalSpace(size: 10),

                // dob text and textfield
                const AppText(
                  text: 'Date of Birth',
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                  size: 12,
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
                  onSaved: (String? dob) => _registerParams.dateOfBirth = dob!,
                  validator: (dob) {
                    if (dateOfBirth == null) {
                      return 'Please pick a date';
                    }
                    return null;
                  },
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
                  child: const AppText(
                    text: 'Have a referral code?',
                    color: AppColors.gunMetal,
                    fontWeight: FontWeight.w600,
                    size: 12,
                  ),
                ),

                const VerticalSpace(size: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                      height: 10,
                      child: Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return AppColors.backgroundColor;
                          }
                          return AppColors.primaryColor;
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        value: acceptedTC,
                        onChanged: (bool? value) {
                          setState(() {
                            acceptedTC = value;
                          });
                        },
                      ),
                    ),
                    const HorizontalSpace(
                      size: 10,
                    ),
                    Row(
                      children: const [
                        AppText(
                          text: 'I accept and agree to all ',
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          size: 10,
                        ),
                        AppText(
                          text: 'terms and conditions',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                          size: 10,
                        ),
                      ],
                    ),
                  ],
                ),

                const VerticalSpace(size: 15),

                Consumer<AuthenticationProvider>(
                    builder: (context, authProvider, __) {
                  return Container(
                    child: acceptedTC!
                        ? GeneralButton(
                            onPressed: () {
                              acceptedTC!
                                  ? _handleRegister(authProvider)
                                  : null;
                              // navigationService
                              //     .navigateToRoute(const DashboardScreen());
                            },
                            buttonTextColor: Colors.white,
                            isLoading:
                                authProvider.loadingState == LoadingState.busy,
                            child: const Text('Next'),
                          )
                        : DisabledButton(
                            onPressed: () => acceptedTC!
                                ? navigationService
                                    .navigateTo(RouteName.verifyOTP)
                                : null,
                            buttonTextColor: Colors.white,
                            child: const Text('Next'),
                          ),
                  );
                }),

                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ).paddingSymmetric(horizontal: 24),
      ),
    );
  }

  _handleRegister(AuthenticationProvider authProvider) async {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      authProvider.updateRegisterParams(_registerParams);
      await authProvider.initiateRegistration(context);
    }
  }
}
