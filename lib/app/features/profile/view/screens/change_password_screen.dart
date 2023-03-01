import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/extensions/validator_extension.dart';
import 'package:floatr/app/features/profile/data/model/params/change_password_params.dart';
import 'package:floatr/app/features/profile/providers/user_profile_provider.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/providers/base_provider.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_keyboard.dart';
import '../../../../widgets/dialogs.dart';
import '../../../../widgets/general_button.dart';
import '../../../../widgets/modal_pill.dart';
import '../../../../widgets/text_field.dart';
import '../../../dashboard/view/widgets/highlights_card.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  final passwordValidator = ValidationBuilder().password().build();

  late ChangePasswordParams _changePasswordParams;

  @override
  void initState() {
    super.initState();
    _changePasswordParams = ChangePasswordParams();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => UserProfileProvider(profileRepository: di()),
        builder: (context, _) {
          return Consumer<UserProfileProvider>(
            builder: (context, profileProvider, _) {
              return Scaffold(
                appBar: CustomAppBar(),
                resizeToAvoidBottomInset: false,
                body: SafeArea(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: 'Change Password',
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w900,
                          size: context.widthPx * 0.089,
                        ),

                        const VerticalSpace(
                          size: 40,
                        ),

                        // current password
                        AppText(
                          text: 'Current Password',
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          size: context.widthPx * 0.035,
                        ),

                        const VerticalSpace(size: 10),

                        AppTextField(
                          hintText: 'Password',
                          controller: currentPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          validator: passwordValidator,
                          onSaved: (String? password) =>
                              _changePasswordParams.password = password,
                          textInputAction: TextInputAction.unspecified,
                        ),

                        const VerticalSpace(
                          size: 20,
                        ),

                        // new password
                        AppText(
                          text: 'New Password',
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          size: context.widthPx * 0.035,
                        ),

                        const VerticalSpace(size: 10),

                        AppTextField(
                          hintText: 'Password',
                          controller: newPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          validator: (newpassword) {
                            if (newpassword == currentPasswordController.text) {
                              return 'New password should be different from old password';
                            } else if (newpassword == null) {
                              return 'New password field is required';
                            }
                            return null;
                          },
                          onSaved: (String? password) =>
                              _changePasswordParams.newPassword = password,
                          // _resetPasswordParams.phoneNumber = phone,
                          textInputAction: TextInputAction.unspecified,
                        ),

                        const VerticalSpace(
                          size: 20,
                        ),

                        // confrim password
                        AppText(
                          text: 'Confirm New Password',
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          size: context.widthPx * 0.035,
                        ),
                        const VerticalSpace(size: 10),
                        AppTextField(
                          hintText: 'Password',
                          controller: confirmNewPasswordController,
                          textInputType: TextInputType.visiblePassword,
                          validator: (confirmpassword) {
                            if (confirmpassword != newPasswordController.text) {
                              return 'New password doesn\'t match';
                            } else if (confirmpassword == null) {
                              return 'New password confirmation field is required';
                            }
                            return null;
                          },
                          // onSaved: (String? password) => _,
                          // _resetPasswordParams.phoneNumber = phone,
                          textInputAction: TextInputAction.unspecified,
                        ),
                        const Spacer(),

                        GeneralButton(
                          // isLoading: provider.loadingState == LoadingState.busy,
                          onPressed: () => _handleChangePassword(),
                          buttonTextColor: Colors.white,
                          backgroundColor: AppColors.primaryColor,

                          borderColor: AppColors.primaryColor,
                          child: const Text(
                            'RESET PASWORD',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ).paddingSymmetric(horizontal: context.widthPx * 0.037),
              );
            },
          );
        });
  }

  _showPinDialog(UserProfileProvider profileProvider) {
    bool isLoading = false;
    AppDialog.showAppDialog(
        context,
        ChangeNotifierProvider(
          create: (context) => KeyboardProvider()
            ..updateControllerActiveStatus(shouldDeactivateController: true)
            ..updateRequiredLength(6),
          child: Consumer<KeyboardProvider>(
            builder: (context, keyboard, _) {
              return Container(
                // height: 741,
                width: context.widthPx,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(24)),
                child: Column(
                  children: [
                    const ModalPill(),

                    const VerticalSpace(size: 25),

                    SizedBox(
                      height: 75,
                      child: Column(
                        children: [
                          Text(
                            'Confirm Pin',
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
                        onPressed: () async {
                          if (keyboard.isFilled) {
                            final pin =
                                keyboard.inputs.map((n) => n.toString()).join();

                            _changePasswordParams.pin = pin;
                            profileProvider.updateChangePasswordParams(
                                _changePasswordParams);

                            // force loading
                            setState(() => isLoading = true);

                            profileProvider.changePassword().then((value) {
                              if (profileProvider.loadingState ==
                                  LoadingState.error) {
                                AppSnackBar.showErrorSnackBar(
                                    context, profileProvider.errorMsg);
                                di<NavigationService>().pop(); // pop dialog
                              } else if (profileProvider.loadingState ==
                                  LoadingState.loaded) {
                                di<NavigationService>()
                                  ..pop()
                                  ..pop(); // pop dialog and change password screen
                                Fluttertoast.showToast(
                                    msg: 'Password change successfully.');
                              }
                            });
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

  _handleChangePassword() async {
    final isValid = formKey.currentState!.validate();
    final provider = context.read<UserProfileProvider>();

    if (isValid) {
      formKey.currentState!.save();

      _showPinDialog(provider);
    }
  }
}
