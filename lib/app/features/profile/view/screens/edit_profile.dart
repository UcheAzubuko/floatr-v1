import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/profile/data/model/responses/country_repsonse.dart';
import 'package:floatr/app/features/profile/data/model/responses/state_repsonse.dart'
    as state;
import 'package:floatr/app/features/profile/providers/user_resources_provider.dart';
import 'package:floatr/app/features/profile/view/widgets/account_info_card.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/custom_appbar.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../authentication/providers/authentication_provider.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.editProfileView})
      : super(key: key);

  final EditProfile editProfileView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.widthPx,
          child: _view(editProfileView),
        ),
      ),
    );
  }
}

class EditResidentialAddressView extends StatefulWidget {
  const EditResidentialAddressView({super.key});

  @override
  State<EditResidentialAddressView> createState() =>
      _EditResidentialAddressViewState();
}

class _EditResidentialAddressViewState
    extends State<EditResidentialAddressView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => context.read<UserResourcesProvider>().getCountries());
    super.initState();
  }

  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();

  final _cityValidator =
      ValidationBuilder().minLength(10).maxLength(20).build();
  final _streetValidator =
      ValidationBuilder().minLength(10).maxLength(50).build();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();

    // List<String> states = [
    //   'Select State',
    //   'Abia',
    //   'Adamawa',
    //   'Akwa Ibom',
    //   'Anambra',
    //   'Bauchi',
    //   'Bayelsa',
    //   'Benue',
    //   'Borno',
    //   'Cross River',
    //   'Delta',
    //   'Ebonyi',
    //   'Edo',
    //   'Ekiti',
    //   'Enugu',
    //   'Gombe',
    //   'Imo',
    //   'Jigawa',
    //   'Kaduna',
    //   'Kano',
    //   'Katsina',
    //   'Kebbi',
    //   'Kogi',
    //   'Kwara',
    //   'Lagos',
    //   'Nasarawa',
    //   'Niger',
    //   'Ogun',
    //   'Ondo',
    //   'Osun',
    //   'Oyo',
    //   'Plateau',
    //   'Rivers',
    //   'Sokoto',
    //   'Taraba',
    //   'Yobe',
    //   'Zamfara'
    // ];

    Country? selectedCountry;
    state.State? selectedState;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // const VerticalSpace(size: 60),

          const VerticalSpace(size: 30),

          // primary info
          AccountInfoCard(
            height: 433,
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
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Select',
                                hintStyle: TextStyle(
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
                              setState(() => selectedCountry = country);

                              await context
                                  .read<UserResourcesProvider>()
                                  .getStates(selectedCountry!.id!);
                            },
                            value: selectedCountry,
                          );
                        }),
                    // Consumer<UserResourcesProvider>(
                    //   builder: (context, provider, _) {
                    //     switch (provider.loadingState) {
                    //       case LoadingState.busy:
                    //         return Container(
                    //           width: context.widthPx,
                    //           height: 41,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           child: Align(
                    //               alignment: Alignment.centerLeft,
                    //               child: Text(
                    //                 'Loading countries...',
                    //                 style: TextStyle(
                    //                     color: AppColors.grey.withOpacity(0.5),
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.w500),
                    //               )),
                    //         );
                    //       case LoadingState.loaded:
                    //         return DropdownButtonFormField<Country>(
                    //           decoration: const InputDecoration.collapsed(
                    //               hintText: 'Select',
                    //               hintStyle: TextStyle(
                    //                   color: AppColors.black,
                    //                   fontSize: 12,
                    //                   fontWeight: FontWeight.w500)),
                    //           // value: ,
                    //           focusColor: AppColors.black,

                    //           borderRadius: BorderRadius.circular(12),
                    //           icon: Icon(
                    //             Icons.keyboard_arrow_down_rounded,
                    //             color: AppColors.grey.withOpacity(0.3),
                    //           ),
                    //           isExpanded: true,
                    //           items: provider.countryRepsonse!.countries
                    //               .map(
                    //                 (Country country) =>
                    //                     DropdownMenuItem<Country>(
                    //                   value: country,
                    //                   child: AppText(
                    //                     text: country.name!,
                    //                     fontWeight: FontWeight.w500,
                    //                     size: 12,
                    //                   ),
                    //                 ),
                    //               )
                    //               .toList(),
                    //           onChanged: (Country? country) {
                    //             setState(() => selcetedCountry = country);

                    //             context
                    //                 .read<UserResourcesProvider>()
                    //                 .getStates(selcetedCountry!.id!);
                    //           },
                    //           value: selcetedCountry,
                    //         );
                    //       default:
                    //         return Container(
                    //           width: context.widthPx,
                    //           height: 41,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(12),
                    //           ),
                    //           child: const Text('Loading Countries...'),
                    //         );
                    //     }
                    //   },
                    // ),
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
                    child: Selector<UserResourcesProvider, state.StateResponse>(
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
                            decoration: const InputDecoration.collapsed(
                                hintText: 'Select',
                                hintStyle: TextStyle(
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
                              setState(() => selectedState = state);

                              // context
                              //     .read<UserResourcesProvider>()
                              //     .getStates(selcetedCountry!.id!);
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
                AppTextField(controller: cityController),

                const VerticalSpace(size: 10),

                // street add
                Text(
                  'Street Address',
                  style: TextStyles.smallTextDark14Px,
                ).paddingOnly(bottom: 8),
                AppTextField(controller: streetController),

                const VerticalSpace(size: 10),
              ],
            ),
          ),

          const VerticalSpace(size: 30),

          GeneralButton(
            onPressed: () => navigationService.pop(),
            height: 48,
            borderRadius: 12,
            child: const AppText(
              text: 'UPDATE',
              color: Colors.white,
              fontWeight: FontWeight.w700,
              size: 16,
              letterSpacing: 1.5,
            ),
          ),

          const VerticalSpace(size: 40),
        ],
      ),
    );
  }

  _handleUpdateResidentialAddress() async {
    final bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }
}

class EditEmploymentView extends StatelessWidget {
  const EditEmploymentView({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const VerticalSpace(size: 60),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          width: context.widthPx,
          height: 520,
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
              AppTextField(controller: TextEditingController(text: '')),

              const VerticalSpace(size: 10),

              // employers address
              Text(
                'Employer\'s address',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Lekki')),

              const VerticalSpace(size: 10),

              // employment type
              Text(
                'Employment type',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Single')),

              const VerticalSpace(size: 10),

              // position
              Text(
                'Position (Title)',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Hokage')),

              const VerticalSpace(size: 10),

              // monthly income
              Text(
                'Monthly Income',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: '120000')),

              const VerticalSpace(size: 10),
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        GeneralButton(
          onPressed: () => navigationService.pop(),
          height: 48,
          borderRadius: 12,
          child: const AppText(
            text: 'UPDATE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class EditNextOfKinView extends StatelessWidget {
  const EditNextOfKinView({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // const VerticalSpace(size: 60),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          height: 440,
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
              AppTextField(controller: TextEditingController(text: 'Nigeria')),

              const VerticalSpace(size: 10),

              // name
              Text(
                'Full Name (Surname first)',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Nigeria')),

              const VerticalSpace(size: 10),

              // Phone Number
              Text(
                'Phone Number',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Nigeria')),

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
              AppTextField(controller: TextEditingController(text: 'Nigeria')),

              const VerticalSpace(size: 10),
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        AccountInfoCard(
          height: 430,
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
              AppTextField(controller: TextEditingController(text: 'Nigeria')),

              const VerticalSpace(size: 10),

              // state
              Text(
                'State',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Lagos')),

              const VerticalSpace(size: 10),

              // city
              Text(
                'City',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Lekki')),

              const VerticalSpace(size: 10),

              // street add
              Text(
                'Street Address',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'qwertyi')),

              const VerticalSpace(size: 10),
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        GeneralButton(
          onPressed: () => navigationService.pop(),
          height: 48,
          borderRadius: 12,
          child: const AppText(
            text: 'UPDATE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationProvider>().user;
    NavigationService navigationService = di<NavigationService>();

    DateFormat dateFormat = DateFormat('yyyy-MMM-dd');

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
        AccountInfoCard(
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
              AppTextField(controller: TextEditingController(text: 'Single')),

              const VerticalSpace(size: 10),

              // Gender
              Text(
                'Gender',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Female')),

              const VerticalSpace(size: 10),

              Text(
                'State of Origin',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(
                  controller: TextEditingController(text: 'Imo state')),
            ],
          ),
        ),

        const VerticalSpace(size: 40),

        GeneralButton(
          onPressed: () => navigationService.pop(),
          height: 48,
          child: const AppText(
            text: 'SAVE CHANGES',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class PrimaryInfoItem extends StatelessWidget {
  const PrimaryInfoItem({
    Key? key,
    required this.subText,
    required this.text,
  }) : super(key: key);

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyles.smallTextDark14Px,
        ).paddingOnly(bottom: 5),
        Text(subText, style: TextStyles.smallTextGrey14Px),
      ],
    ).paddingOnly(top: 12);
  }
}

Widget _view(EditProfile editProfile) {
  switch (editProfile) {
    case EditProfile.personalDetails:
      return const EditProfileView();
    case EditProfile.nextOfKin:
      return const EditNextOfKinView();
    case EditProfile.residentialAddress:
      return const EditResidentialAddressView();
    case EditProfile.employmentDetails:
      return const EditEmploymentView();
    default:
      return const EditProfileView();
  }
}

enum EditProfile {
  personalDetails,
  residentialAddress,
  employmentDetails,
  nextOfKin,
}

class EditProfileArguments {
  final EditProfile editProfileView;

  EditProfileArguments({required this.editProfileView});
}
