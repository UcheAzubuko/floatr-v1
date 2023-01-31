// ignore_for_file: use_build_context_synchronously

import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';


import '../../../../../../core/misc/dependency_injectors.dart';
import '../../../../../../core/misc/helper_functions.dart';
import '../../../../../../core/providers/base_provider.dart';
import '../../../../../../core/route/navigation_service.dart';
import '../../../../../../core/route/route_names.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_style.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../widgets/app_snackbar.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/general_button.dart';
import '../../../../../widgets/text_field.dart';
import '../../../../authentication/providers/authentication_provider.dart';
import '../../../data/model/params/employer_information_params.dart';
import '../../../data/model/params/employment_type.dart';
import '../../../data/model/user_helper.dart';
import '../../../providers/user_profile_provider.dart';
import '../../widgets/account_info_card.dart';
import '../edit_profile.dart';
class EditEmploymentView extends StatefulWidget {
  const EditEmploymentView({super.key});

  @override
  State<EditEmploymentView> createState() => _EditEmploymentViewState();
}

class _EditEmploymentViewState extends State<EditEmploymentView> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController employerAddressController = TextEditingController();
  TextEditingController employmentTypeController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController monthlyIncomeController = TextEditingController();

  final _companyNameValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _employerAddressValidator =
      ValidationBuilder().minLength(10).maxLength(50).build();
  // final _employmentTypeValidator =
  //     ValidationBuilder().minLength(5).maxLength(20).build();
  final _positionTypeValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _monthlyIncomeValidator = ValidationBuilder().minLength(5).build();
  final _formKey = GlobalKey<FormState>();

  late EmployerInformationParams _employerInformationParams;

  @override
  void initState() {
    _employerInformationParams = EmployerInformationParams(
        employerName: null,
        type: null,
        minMonthlyIncome: null,
        maxMonthlyIncome: null,
        position: null,
        employerAddress: null);
    super.initState();
  }

  final NavigationService _navigationService = di<NavigationService>();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationProvider>().user;

    Employment_? selectedEmployment;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const VerticalSpace(size: 60),

          const VerticalSpace(size: 30),

          // primary info
          AccountInfoCard(
            width: context.widthPx,
            height: 620,
            infoTitle: 'Employer’s Information',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(size: 20),

                // company name
                Text(
                  'Company Name',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),
                AppTextField(
                  controller: companyNameController
                    ..text = user!.employment!.employerName ?? '',
                  hintText: 'Xone tech',
                  validator: _companyNameValidator,
                  onSaved: (String? employerName) =>
                      _employerInformationParams.employerName = employerName,
                ),

                const VerticalSpace(size: 10),

                // employers address
                Text(
                  'Employer\'s address',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),
                AppTextField(
                  controller: employerAddressController
                    ..text = user.employment!.employerAddress ?? '',
                  validator: _employerAddressValidator,
                  hintText: '18 Sing street, planning way',
                  onSaved: (String? employerAddress) =>
                      _employerInformationParams.employerAddress =
                          employerAddress,
                ),

                const VerticalSpace(size: 10),

                // employment type
                Text(
                  'Employment type',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),
                Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    child: DropdownButtonFormField<Employment_>(
                      decoration: InputDecoration.collapsed(
                          hintText: EmploymentType.showCorrectEmploymentFormat(user.employment?.type) ?? 'Select',
                          hintStyle: const TextStyle(
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
                      items:
                          EmploymentType.fromMap(EmploymentType.employmentBody)
                              .employmentTypes
                              .map(
                                (Employment_ employment_) =>
                                    DropdownMenuItem<Employment_>(
                                  value: employment_,
                                  child: AppText(
                                    text: employment_.type,
                                    fontWeight: FontWeight.w500,
                                    size: 12,
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (Employment_? employment_) async {
                        // setState(() {
                        selectedEmployment = employment_;
                        _employerInformationParams.type = employment_!.id;
                        // });
                      },
                      value: selectedEmployment,
                      onSaved: (Employment_? employment_) {
                        // this checks are being done just incase if the user already has
                        // those details filled, he doesn't have to reselect them to proceed
                        if (employment_ != null) {
                          _employerInformationParams.type = employment_.id;
                        } else {
                          _employerInformationParams.type =
                              _employerInformationParams.type;
                        }
                      },
                    ),
                  ),
                ),

                const VerticalSpace(size: 10),

                // position
                Text(
                  'Position (Title)',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),

                AppTextField(
                  controller: positionController
                    ..text = user.employment!.position ?? '',
                  validator: _positionTypeValidator,
                  hintText: 'Head of Department',
                  onSaved: (String? position) =>
                      _employerInformationParams.position = position,
                ),

                const VerticalSpace(size: 10),

                // monthly income
                Text(
                  'Monthly Income',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),

                AppTextField(
                  controller: monthlyIncomeController
                    ..text = doubleStringToIntString(user.employment!.minMonthlyIncome) ?? '',
                  textInputType: const TextInputType.numberWithOptions(),
                  validator: _monthlyIncomeValidator,
                  hintText: '120000',
                  onSaved: (String? income) =>
                      _employerInformationParams.minMonthlyIncome = income,
                ),

                const VerticalSpace(size: 10),
              ],
            ),
          ),

          const VerticalSpace(size: 30),

          Consumer<UserProfileProvider>(builder: (context, provider, __) {
            return GeneralButton(
              onPressed: () => _handleEmployerInfoUpdate(provider),
              height: 48,
              borderRadius: 12,
              isLoading: provider.loadingState == LoadingState.busy,
              child: const AppText(
                text: 'UPDATE',
                color: Colors.white,
                fontWeight: FontWeight.w700,
                size: 16,
                letterSpacing: 1.5,
              ),
            );
          }),

          const VerticalSpace(size: 40),
        ],
      ),
    );
  }

  _handleEmployerInfoUpdate(UserProfileProvider provider) async {
    final bool isValid = _formKey.currentState!.validate();
    final authProvider = context.read<AuthenticationProvider>();
    final user = authProvider.user;

    if (isValid) {
      _formKey.currentState!.save();
      provider.updateEmployerInformationParams(_employerInformationParams);
      await provider.updateEmploymentInformation();
      if (provider.loadingState == LoadingState.loaded) {
        await authProvider.getUser(); // update user
        if (!UserHelper(user: user!).isNextOfKinComplete) {
          _navigationService.navigateReplacementTo(RouteName.editProfile,
              arguments:
                  EditProfileArguments(editProfileView: EditProfile.nextOfKin));
        } else {
          _navigationService.pop();
        }
        Fluttertoast.showToast(
            msg: 'Employer info update successful',
            backgroundColor: Colors.blue);
      } else if (provider.loadingState == LoadingState.error) {
        AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
      }
    }
  }
}
