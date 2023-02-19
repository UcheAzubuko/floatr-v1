import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/extensions/validator_extension.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/dialogs.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/text_field.dart';
import '../data/model/params/reset_password_params.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  NavigationService navigationService = di<NavigationService>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late ResetPasswordParams _resetPasswordParams;

  final _passwordValidator = ValidationBuilder().password().build();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _resetPasswordParams = ResetPasswordParams(password: null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: 'Reset Password',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.089,
              ),

              // sub text
              AppText(
                text: 'Create your new password',
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 50),
              // new password text and textfield
              AppText(
                text: 'New Password',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                hintText: 'Password',
                controller: TextEditingController(),
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.unspecified,
                onSaved: (String? password) =>
                    _resetPasswordParams.password = password,
                validator: _passwordValidator,
              ),

              const VerticalSpace(size: 10),

              // confirm password text and textfield
              AppText(
                text: 'Confirm Password',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.035,
              ),

              const VerticalSpace(size: 10),

              AppTextField(
                hintText: 'Passwords must match',
                controller: confirmPasswordController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.unspecified,
                validator: (password) {
                  if (passwordController.text != password) {
                    return 'Both Passwords are not the same.';
                  }
                  return null;
                },
              ),

              const Spacer(),

              Consumer<AuthenticationProvider>(
                builder: (context, provider, _) {
                  return GeneralButton(
                    isLoading: provider.loadingState == LoadingState.busy,
                    onPressed: () => _handleResetPassword(provider),
                    buttonTextColor: Colors.white,
                    backgroundColor: AppColors.primaryColor,
                    borderColor: AppColors.primaryColor,
                    child: const Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),

              SizedBox(height: context.heightPx * 0.03),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }

  _handleResetPassword(AuthenticationProvider provider) {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      provider.updateResetPasswordParams(_resetPasswordParams);
      provider.resetPassword().then((_) {
        if (provider.loadingState == LoadingState.loaded) {
          AppDialog.showAppDialog(
              context,
              OnSuccessDialogContent(
                subtext: 'You can now log in with your new password!',
                onDoneCallback: () {},
              ));
        } else if (provider.loadingState == LoadingState.error) {
          AppDialog.showAppDialog(
              context,
              OnFailDialogContent(
                subtext: 'Password Change failed!',
                onDoneCallback: () {},
              ));
        }
      });
    }
  }
}
