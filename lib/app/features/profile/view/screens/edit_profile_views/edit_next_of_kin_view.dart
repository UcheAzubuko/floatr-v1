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
import '../../../../../../core/utils/app_colors.dart';
import '../../../../../../core/utils/app_style.dart';
import '../../../../../../core/utils/spacing.dart';
import '../../../../../widgets/app_snackbar.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/general_button.dart';
import '../../../../../widgets/text_field.dart';
import '../../../../authentication/providers/authentication_provider.dart';
import '../../../data/model/params/next_of_kin_params.dart';
import '../../../data/model/responses/country_repsonse.dart';
import '../../../providers/user_profile_provider.dart';
import '../../../providers/user_resources_provider.dart';
import '../../widgets/account_info_card.dart';

class EditNextOfKinView extends StatefulWidget {
  const EditNextOfKinView({super.key});

  @override
  State<EditNextOfKinView> createState() => _EditNextOfKinViewState();
}

class _EditNextOfKinViewState extends State<EditNextOfKinView> {
  late NextOfKinParams _nextOfKinParams;

  TextEditingController cityController = TextEditingController();
  TextEditingController relationshipController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final _cityValidator = ValidationBuilder().minLength(2).maxLength(50).build();
  final _streetValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _relationshipValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _fullnameValidator =
      ValidationBuilder().minLength(2).maxLength(50).build();
  final _emailValidator = ValidationBuilder().email().build();
  final _phoneValidator = ValidationBuilder().phone().build();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    final user = context.read<AuthenticationProvider>().user;
    final userResources = context.read<UserResourcesProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      userResources.getCountries();

      // only perform this call if user
      // already has a country selected, so that states are available to be selected in the dropdown
      if (user!.country != null) {
        userResources.getStates(user.country!.id!);
      }
    });

    final nextOfKin = user!.nextOfKin!;

    if (user.nextOfKin != null) {
      _nextOfKinParams = NextOfKinParams(
          firstName: nextOfKin.firstName,
          lastName: nextOfKin.lastName,
          relationship: nextOfKin.relationship,
          email: nextOfKin.email,
          phoneNumber: nextOfKin.phoneNumber,
          countryId: nextOfKin.country?.id,
          stateId: nextOfKin.state?.id,
          city: nextOfKin.city,
          address: nextOfKin.address);
    }

    // _nextOfKinParams = NextOfKinParams(
    //     firstName: user!.nextOfKin!.firstName,
    //     lastName: user.nextOfKin!.lastName,
    //     relationship: user.nextOfKin!.relationship,
    //     email: user.nextOfKin!.email,
    //     phoneNumber: user.nextOfKin!.phoneNumber,
    //     countryId: user.nextOfKin!.country!.id,
    //     stateId: user.nextOfKin!.state!.id,
    //     city: user.nextOfKin!.city,
    //     address: user.nextOfKin!.address);
    super.initState();
  }

  final NavigationService _navigationService = di<NavigationService>();

  @override
  Widget build(BuildContext context) {
    Country? selectedCountry;
    state.State? selectedState;

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const VerticalSpace(size: 60),

              const VerticalSpace(size: 30),

              // primary info
              AccountInfoCard(
                height: 510,
                width: context.widthPx,
                infoTitle: 'Next of Kin (Personal Details)',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    const VerticalSpace(size: 20),

                    // relationship
                    Text(
                      'Relationship',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: relationshipController
                        ..text =
                            authProvider.user!.nextOfKin!.relationship ?? '',
                      validator: _relationshipValidator,
                      hintText: 'Brother',
                      onSaved: (String? relationship) =>
                          _nextOfKinParams.relationship = relationship,
                    ),

                    const VerticalSpace(size: 10),

                    // name
                    Text(
                      'Full Name (Surname first)',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),

                    AppTextField(
                        controller: fullnameController
                          ..text =
                              '${authProvider.user!.nextOfKin!.firstName ?? ''} ${authProvider.user!.nextOfKin!.lastName ?? ''}',
                        validator: _fullnameValidator,
                        hintText: 'Okeke Ali',
                        onSaved: (String? fullname) {
                          var separateNames = fullname!.split(' ');
                          _nextOfKinParams.firstName = separateNames[0];
                          _nextOfKinParams.lastName = separateNames[1];
                        }),

                    const VerticalSpace(size: 10),

                    // Phone Number
                    Text(
                      'Phone Number',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: phoneController
                        ..text =
                            authProvider.user!.nextOfKin!.phoneNumber ?? '',
                      validator: _phoneValidator,
                      hintText: '+234908976543',
                      onSaved: (String? phone) =>
                          _nextOfKinParams.phoneNumber = phone,
                    ),

                    const VerticalSpace(size: 10),

                    // phone number
                    // Text(
                    //   'Email Address',
                    //   style: TextStyles.smallTextDark14Px,
                    // ).paddingOnly(bottom: 8),
                    // AppTextField(controller: TextEditingController(text: 'Nigeria')),

                    // const VerticalSpace(size: 10),

                    // email address
                    Text(
                      'Email Address',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: emailController
                        ..text = authProvider.user!.nextOfKin!.email ?? '',
                      validator: _emailValidator,
                      hintText: 'okeke@gmail.com',
                      onSaved: (String? email) =>
                          _nextOfKinParams.email = email,
                    ),

                    const VerticalSpace(size: 10),
                  ],
                ),
              ),

              const VerticalSpace(size: 30),

              AccountInfoCard(
                height: 448,
                width: context.widthPx,
                infoTitle: 'Next of Kin Address',
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
                                    hintText: authProvider
                                            .user?.nextOfKin?.country?.name ??
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
                                  // setState(() {
                                  selectedCountry = country;
                                  _nextOfKinParams.countryId = country!.id;
                                  // });

                                  await context
                                      .read<UserResourcesProvider>()
                                      .getStates(selectedCountry!.id!);
                                },
                                value: selectedCountry,
                                onSaved: (Country? country) {
                                  // this checks are being done just incase if the user already has
                                  // those details filled, he doesn't have to reselect them to proceed
                                  if (country != null) {
                                    _nextOfKinParams.countryId = country.id;
                                  } else {
                                    _nextOfKinParams.countryId =
                                        _nextOfKinParams.countryId;
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
                                    hintText: authProvider
                                            .user?.nextOfKin?.state?.name ??
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
                                  // setState(() {
                                  selectedState = state;
                                  _nextOfKinParams.stateId = state!.id;
                                  // });

                                  // context
                                  //     .read<UserResourcesProvider>()
                                  //     .getStates(selcetedCountry!.id!);
                                },
                                onSaved: (state.State? state) {
                                  // this checks are being done just incase if the user already has
                                  // those details filled, he doesn't have to reselect them to proceed
                                  if (state != null) {
                                    _nextOfKinParams.stateId = state.id;
                                  } else {
                                    _nextOfKinParams.stateId =
                                        _nextOfKinParams.stateId;
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
                        ..text = authProvider.user!.nextOfKin!.city ?? '',
                      validator: _cityValidator,
                      hintText: 'Ikeja',
                      onSaved: (String? city) => _nextOfKinParams.city = city,
                    ),

                    const VerticalSpace(size: 10),

                    // street add
                    Text(
                      'Street Address',
                      style: TextStyles.smallTextDark14Px,
                    ).paddingOnly(bottom: 8),
                    AppTextField(
                      controller: streetController
                        ..text = authProvider.user!.nextOfKin!.address ?? '',
                      validator: _streetValidator,
                      hintText: '18 first street, town',
                      onSaved: (String? address) =>
                          _nextOfKinParams.address = address,
                    ),

                    const VerticalSpace(size: 10),
                  ],
                ),
              ),

              const VerticalSpace(size: 30),

              Consumer<UserProfileProvider>(builder: (context, provider, __) {
                return GeneralButton(
                  onPressed: () => _handleUpdateNextOfKin(provider),
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
          );
        },
      ),
    );
  }

  _handleUpdateNextOfKin(
    UserProfileProvider provider,
  ) async {
    final bool isValid = _formKey.currentState!.validate();
    final authProvider = context.read<AuthenticationProvider>();

    if (!isValid) {
      if (_nextOfKinParams.countryId == null ||
          _nextOfKinParams.stateId == null) {
        AppSnackBar.showErrorSnackBar(
            context, 'Please check your selected country and state.');
      }
    } else {
      _formKey.currentState!.save();
      provider.updateNextOfKinParams(_nextOfKinParams);
      await provider.updateNextOfKin(context);
      if (provider.loadingState == LoadingState.loaded) {
        await authProvider.getUser();
        _navigationService.pop();
        Fluttertoast.showToast(
            msg: 'Next of kin update successful',
            backgroundColor: Colors.blue);
      } else if (provider.loadingState == LoadingState.error) {
        AppSnackBar.showErrorSnackBar(context, provider.errorMsg);
      }
    }
  }
}

