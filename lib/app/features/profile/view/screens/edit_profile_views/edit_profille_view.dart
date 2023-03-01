// ignore_for_file: use_build_context_synchronously

import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:floatr/app/features/profile/data/model/responses/state_repsonse.dart'
    as state;

import '../../../../../../core/misc/dependency_injectors.dart';
import '../../../../../../core/providers/base_provider.dart';
import '../../../../../../core/route/navigation_service.dart';
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_style.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../widgets/app_snackbar.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/dialogs.dart';
import '../../../../../widgets/general_button.dart';
import '../../../../authentication/providers/authentication_provider.dart';
import '../../../data/model/params/user_profile_params.dart';
import '../../../data/model/responses/gender_response.dart';
import '../../../data/model/responses/marital_status_response.dart';
import '../../../data/model/user_helper.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../providers/user_resources_provider.dart';
import '../../widgets/account_info_card.dart';
import '../edit_profile.dart';
import '../profile_screen.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  final NavigationService _navigationService = di<NavigationService>();
  @override
  void initState() {
    final user = context.read<AuthenticationProvider>().user;
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<UserResourcesProvider>()
          ..getMaritalStatuses()
          ..getGenders()
          ..getStates('1275'));

    _userProfileParams = UserProfileParams(
        email: user!.email,
        genderId: user.gender!.id,
        maritalStatusId: user.maritalStatus!.id,
        stateOfOriginId: user.stateOfOrigin!.id);

    super.initState();
  }

  late UserProfileParams _userProfileParams;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationProvider>().user;

    DateFormat dateFormat = DateFormat('yyyy-MMM-dd');

    Gender? selectedGender;
    MaritalStatus? selectedMaritalStatus;
    state.State? selectedState;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpace(size: 60),

        // user image
        CircleAvatar(
            radius: 44, backgroundImage: NetworkImage(user!.photo!.url!)),

        const VerticalSpace(size: 30),

        // primary info
        // Consumer<AuthenticationProvider>(builder: (context, provider, _) {
        //   final user = provider.user;

        AccountInfoCard(
          height: 290,
          width: context.widthPx,
          infoTitle: 'Primary Information',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // fullname
              PrimaryInfoItem(
                text: 'Full Name',
                subText: '${user.firstName} ${user.lastName}',
              ),

              // phone number
              PrimaryInfoItem(
                text: 'Phone Number',
                subText: user.phoneNumber!,
              ),

              // bvn
              PrimaryInfoItem(
                text: 'BVN',
                subText: user.bvn!,
              ),

              // dob
              PrimaryInfoItem(
                text: 'Date of Birth',
                subText: dateFormat.format(user.dateOfBirth!),
              ),
            ],
          ),
        ),
        // }),

        const VerticalSpace(size: 15),

        // others
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: AccountInfoCard(
            infoTitle: 'Others',
            height: 320,
            width: context.widthPx,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const VerticalSpace(size: 10),

                // marital status
                Text(
                  'Marital Status',
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
                    alignment: Alignment.center,
                    child:
                        Selector<UserResourcesProvider, MaritalStatusResponse>(
                            selector: (_, provider) =>
                                provider.maritalStatusResponse ??
                                MaritalStatusResponse(maritalStatuses: [
                                  MaritalStatus(id: '0', name: 'Loading...'),
                                ]),
                            builder: (context, _, __) {
                              return DropdownButtonFormField<MaritalStatus>(
                                decoration: InputDecoration.collapsed(
                                    hintText:
                                        user.maritalStatus!.name ?? 'Select',
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
                                items: _.maritalStatuses
                                    .map(
                                      (MaritalStatus _) =>
                                          DropdownMenuItem<MaritalStatus>(
                                        value: _,
                                        child: AppText(
                                          text: _.name!,
                                          fontWeight: FontWeight.w500,
                                          size: 12,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (MaritalStatus? maritalStatus) {
                                  setState(() {
                                    selectedMaritalStatus = maritalStatus;
                                    _userProfileParams.maritalStatusId =
                                        maritalStatus!.id;
                                  });

                                  // context
                                  //     .read<UserResourcesProvider>()
                                  //     .getStates(selcetedCountry!.id!);
                                },
                                onSaved: (MaritalStatus? maritalStatus) {
                                  if (maritalStatus != null) {
                                    _userProfileParams.maritalStatusId =
                                        maritalStatus.id;
                                  } else {
                                    _userProfileParams.maritalStatusId =
                                        _userProfileParams.maritalStatusId;
                                  }
                                },
                                value: selectedMaritalStatus,
                              );
                            }),
                  ),
                ),

                const VerticalSpace(size: 10),

                // Gender
                Text(
                  'Gender',
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
                    alignment: Alignment.center,
                    child: Selector<UserResourcesProvider, GenderResponse>(
                        selector: (_, provider) =>
                            provider.genderResponse ??
                            GenderResponse(genders: [
                              const Gender(id: '0', name: 'Loading...'),
                            ]),
                        builder: (context, _, __) {
                          return DropdownButtonFormField<Gender>(
                            decoration: InputDecoration.collapsed(
                                hintText: user.gender!.name ?? 'Select',
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
                            items: _.genders
                                .map(
                                  (Gender _) => DropdownMenuItem<Gender>(
                                    value: _,
                                    child: AppText(
                                      text: _.name!,
                                      fontWeight: FontWeight.w500,
                                      size: 12,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (Gender? gender) {
                              // setState(() {
                              selectedGender = gender;
                              _userProfileParams.genderId = gender!.id;
                              // });

                              // context
                              //     .read<UserResourcesProvider>()
                              //     .getStates(selcetedCountry!.id!);
                            },
                            // onSaved: (Gender? gender) {
                            //   _userProfileParams.genderId = gender!.id;
                            // },
                            value: selectedGender,
                          );
                        }),
                  ),
                ),

                const VerticalSpace(size: 10),

                Text(
                  'State of Origin',
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
                    alignment: Alignment.center,
                    child: Selector<UserResourcesProvider, state.StateResponse>(
                        selector: (_, provider) =>
                            provider.stateResponse ??
                            const state.StateResponse(stateResponses: [
                              state.State(id: '0', name: 'Loading..')
                            ]),
                        builder: (context, _, __) {
                          return DropdownButtonFormField<state.State>(
                            decoration: InputDecoration.collapsed(
                                hintText: user.state!.name ?? 'Select',
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
                            items: _.stateResponses
                                .map(
                                  (state.State _) =>
                                      DropdownMenuItem<state.State>(
                                    value: _,
                                    child: AppText(
                                      text: _.name!,
                                      fontWeight: FontWeight.w500,
                                      size: 12,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (state.State? state) {
                              // setState(() {
                              selectedState = state;
                              _userProfileParams.stateOfOriginId = state!.id;
                              // });

                              // context
                              //     .read<UserResourcesProvider>()
                              //     .getStates(selcetedCountry!.id!);
                            },
                            // onSaved: (state.State? state) {
                            //   _userProfileParams.stateOfOriginId = state!.id;
                            // },
                            value: selectedState,
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),

        const VerticalSpace(size: 40),

        Consumer<UserProfileProvider>(builder: (context, provider, __) {
          return GeneralButton(
            onPressed: () => _handleUserProfileInfo(provider),
            height: 48,
            isLoading: provider.loadingState == LoadingState.busy,
            child: const AppText(
              text: 'SAVE CHANGES',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              size: 16,
              letterSpacing: 1.5,
            ),
          );
        }),

        const VerticalSpace(size: 40),
      ],
    );
  }

  _handleUserProfileInfo(UserProfileProvider provider) async {
    final authProvider = context.read<AuthenticationProvider>();

    if (_userProfileParams.maritalStatusId == null) {
      AppSnackBar.showErrorSnackBar(
          context, 'Please select your marital status.');
    } else if (_userProfileParams.genderId == null) {
      AppSnackBar.showErrorSnackBar(context, 'Please select your gender.');
    } else if (_userProfileParams.stateOfOriginId == null) {
      AppSnackBar.showErrorSnackBar(context, 'Please select your state.');
    } else {
      _formKey.currentState!.save();
      provider.updateUserProfileParams(_userProfileParams);
      await provider.updateUserProfiile();
      if (provider.loadingState == LoadingState.loaded) {
        await authProvider.getUser(); // update user
        if (UserHelper(user: authProvider.user!).isIdDataComplete != CriteriaState.notDone) {
          _navigationService.pop();
          AppDialog.showAppModal(
              context, const GovIDModalView(), Colors.transparent);
        } else {
          _navigationService.pop();
        }
        Fluttertoast.showToast(
            msg: 'User personal info update successful',
            backgroundColor: Colors.blue);
      } else if (provider.loadingState == LoadingState.error) {
        AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
      }
    }
  }
}
