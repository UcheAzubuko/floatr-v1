import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/data/model/params/reset_password_params.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/route/route_names.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/keyboard_observer.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with WidgetsBindingObserver {
  final NavigationService navigationService = di<NavigationService>();

  TextEditingController phoneController = TextEditingController();

  final _phoneValidator = ValidationBuilder().phone().build();

  final _formKey = GlobalKey<FormState>();

  late ResetPasswordParams _resetPasswordParams;

  bool isDone = false;

  @override
  void initState() {
    _resetPasswordParams = ResetPasswordParams(phoneNumber: null);
    // Binding observes if keyboard is hidden or not
    WidgetsBinding.instance
        .addObserver(KeyboardObserver(callback: _keyboardCallback));
    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _keyboardCallback() {
    setState(() {
      isDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthenticationProvider>(builder: (context, provider, _) {
        return SafeArea(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: 'Forgot Password',
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w900,
                  size: context.widthPx * 0.089,
                ),
                AppText(
                  text:
                      'Please enter the phone number associated with your account to reset your password.',
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                  size: context.widthPx * 0.035,
                ),
                const VerticalSpace(
                  size: 40,
                ),
                AppText(
                  text: 'Phone number',
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                  size: context.widthPx * 0.035,
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
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                    validator: _phoneValidator,
                    onSaved: (String? phone) =>
                        _resetPasswordParams.phoneNumber = phone,
                    textInputAction: TextInputAction.unspecified,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        isDone = true;
                      });
                    }),
                const Spacer(),
                GeneralButton(
                  isLoading: provider.loadingState == LoadingState.busy,
                  onPressed: () => _handleForgotPassword(provider),
                  buttonTextColor: Colors.white,
                  backgroundColor: isDone
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight,
                  borderColor: isDone
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight,
                  child: const Text(
                    'VERIFY PHONE NUMBER',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ).paddingSymmetric(horizontal: context.widthPx * 0.037);
      }),
    );
  }

  _handleForgotPassword(AuthenticationProvider provider) {
    final isValid = _formKey.currentState!.validate();
    // final provider = context.read<AuthenticationProvider>();

    if (isValid) {
      _formKey.currentState!.save();
      provider.updateResetPasswordParams(_resetPasswordParams);
      // print(provider.resetPasswordParams!.phoneNumber);
      provider.forgotPassword().then((_) {
        
        if (provider.loadingState == LoadingState.loaded) {
          navigationService.navigateTo(RouteName.forgotPasswordOtp);
        } else if (provider.loadingState == LoadingState.error) {
          AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
        }
      });
    }
  }
}
