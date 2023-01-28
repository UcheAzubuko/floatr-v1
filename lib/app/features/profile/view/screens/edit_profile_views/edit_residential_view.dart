import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';

import 'package:floatr/app/features/profile/data/model/responses/state_repsonse.dart'
    as state;

import '../../../../../../core/misc/dependency_injectors.dart';
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
import '../../../data/model/params/residential_address_params.dart';
import '../../../data/model/responses/country_repsonse.dart';
import '../../../data/model/user_helper.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../providers/user_resources_provider.dart';
import '../../widgets/account_info_card.dart';
import '../edit_profile.dart';

class EditResidentialAddressView extends StatefulWidget {
  const EditResidentialAddressView({super.key});

  @override
  State<EditResidentialAddressView> createState() =>
      _EditResidentialAddressViewState();
}

class _EditResidentialAddressViewState
    extends State<EditResidentialAddressView> {
  final NavigationService _navigationService = di<NavigationService>();
  @override
  void initState() {
    final user = context.read<AuthenticationProvider>().user;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserResourcesProvider>().getCountries();

      // only perform this call if user
      // already has a country selected, so that states are available to be selected in the dropdown
      if (user!.country != null) {
        context.read<UserResourcesProvider>().getStates(user.country!.id!);
      }
    });

    _residentialAddressParams = ResidentialAddressParams(
        countryId: user!.country!.id,
        stateId: user.state!.id,
        city: user.city,
        address: user.address);

    super.initState();
  }

  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  final _cityValidator = ValidationBuilder().minLength(2).maxLength(50).build();
  final _streetValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _formKey = GlobalKey<FormState>();

  late ResidentialAddressParams _residentialAddressParams;

  @override
  Widget build(BuildContext context) {

    Country? selectedCountry;
    state.State? selectedState;

    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, __) {
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
                height: 448,
                width: context.widthPx,
                infoTitle: 'Residential Address',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSpace(size: 20),

                    // country
                    Text(
                      'Country',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    // AppTextField(controller: TextEditingController(text: 'Lagos')),
                    Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Selector<UserResourcesProvider, CountryResponse>(
                            selector: (_, provider) =>
                                provider.countryRepsonse ??
                                CountryResponse(
                                  countries: [
                                    const Country(id: '0', name: 'Loading...'),
                                  ],
                                ),
                            builder: (context, _, __) {
                              return DropdownButtonFormField<Country>(
                                decoration: InputDecoration.collapsed(
                                    hintText:
                                        authProvider.user!.country!.name ??
                                            'Select',
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
                                items: _.countries
                                    .map(
                                      (Country country) =>
                                          DropdownMenuItem<Country>(
                                        value: country,
                                        child: AppText(
                                          text: country.name!,
                                          fontWeight: FontWeight.w500,
                                          size: 12,
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (Country? country) async {
                                  setState(() {
                                    selectedCountry = country;
                                    _residentialAddressParams.countryId =
                                        country!.id;
                                  });

                                  await context
                                      .read<UserResourcesProvider>()
                                      .getStates(selectedCountry!.id!);
                                },
                                value: selectedCountry,
                                onSaved: (Country? country) {
                                  // this checks are being done just incase if the user already has
                                  // those details filled, he doesn't have to reselect them to proceed
                                  if (country != null) {
                                    _residentialAddressParams.countryId =
                                        country.id;
                                  } else {
                                    _residentialAddressParams.countryId =
                                        _residentialAddressParams.countryId;
                                  }
                                },
                              );
                            }),
                      ),
                    ),

                    const VerticalSpace(size: 10),

                    // state
                    Text(
                      'State',
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
                        child: Selector<UserResourcesProvider,
                                state.StateResponse>(
                            selector: (_, provider) =>
                                provider.stateResponse ??
                                state.StateResponse(stateResponses: [
                                  state.State(
                                      id: '0',
                                      name: selectedCountry == null
                                          ? 'Please select country'
                                          : 'Loading..')
                                ]),
                            builder: (context, _, __) {
                              return DropdownButtonFormField<state.State>(
                                decoration: InputDecoration.collapsed(
                                    hintText: authProvider.user!.state!.name ??
                                        'Select',
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
                                  setState(() {
                                    selectedState = state;
                                    _residentialAddressParams.stateId =
                                        state!.id;
                                  });

                                  // context
                                  //     .read<UserResourcesProvider>()
                                  //     .getStates(selcetedCountry!.id!);
                                },
                                onSaved: (state.State? state) {
                                  // this checks are being done just incase if the user already has
                                  // those details filled, he doesn't have to reselect them to proceed
                                  if (state != null) {
                                    _residentialAddressParams.stateId =
                                        state.id;
                                  } else {
                                    _residentialAddressParams.stateId =
                                        _residentialAddressParams.stateId;
                                  }
                                },
                                value: selectedState,
                              );
                            }),
                      ),
                    ),

                    const VerticalSpace(size: 10),

                    // city
                    Text(
                      'City',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: cityController
                        ..text = authProvider.user!.city ?? '',
                      validator: _cityValidator,
                      hintText: 'Ikeja',
                      onSaved: (String? city) =>
                          _residentialAddressParams.city = city,
                    ),

                    const VerticalSpace(size: 10),

                    // street add
                    Text(
                      'Street Address',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: streetController
                        ..text = authProvider.user!.address ?? '',
                      validator: _streetValidator,
                      hintText: '18 first street, town',
                      onSaved: (String? address) =>
                          _residentialAddressParams.address = address,
                    ),

                    const VerticalSpace(size: 10),
                  ],
                ),
              ),

              const VerticalSpace(size: 30),

              Consumer<UserProfileProvider>(builder: (context, provider, __) {
                return GeneralButton(
                  onPressed: () => _handleUpdateResidentialAddress(provider),
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
      },
    );
  }

  _handleUpdateResidentialAddress(UserProfileProvider provider) async {
    final bool isValid = _formKey.currentState!.validate();
    final authProvider = context.read<AuthenticationProvider>();

    if (!isValid) {
      if (_residentialAddressParams.countryId == null ||
          _residentialAddressParams.stateId == null) {
        AppSnackBar.showErrorSnackBar(
            context, 'Please check your selected country and state.');
      }
    } else {
      _formKey.currentState!.save();
      provider.updateResidentialParams(_residentialAddressParams);
      await provider.updateResidentialAddress();
      if (provider.loadingState == LoadingState.loaded) {
        await authProvider.getUser(); // update user
        if (!UserHelper(user: authProvider.user!).isEmployerDetailsComplete) {
          _navigationService.navigateReplacementTo(RouteName.editProfile,
              arguments: EditProfileArguments(
                  editProfileView: EditProfile.employmentDetails));
        } else {
          _navigationService.pop();
        }
        Fluttertoast.showToast(
            msg: 'Residential address update successful',
            backgroundColor: Colors.blue);
      } else if (provider.loadingState == LoadingState.error) {
        AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
      }
    }
  }
}
