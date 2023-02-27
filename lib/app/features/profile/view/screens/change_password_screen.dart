import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/general_button.dart';
import '../../../../widgets/text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmNewPasswordController = TextEditingController();


    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          // key: _formKey,
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
                // validator: _phoneValidator,
                onSaved: (String? password) => {},
               
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
                // validator: _phoneValidator,
                onSaved: (String? password) => {},
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
                // validator: _phoneValidator,
                onSaved: (String? password) => {},
                // _resetPasswordParams.phoneNumber = phone,
                textInputAction: TextInputAction.unspecified,
                
              ),
              const Spacer(),

              GeneralButton(
                // isLoading: provider.loadingState == LoadingState.busy,
                onPressed: () {},
                buttonTextColor: Colors.white,
                backgroundColor: AppColors.primaryColor,
                   
                borderColor:  AppColors.primaryColor
                    ,
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
  }
}
