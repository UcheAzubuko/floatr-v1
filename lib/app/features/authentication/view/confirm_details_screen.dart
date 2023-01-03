import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/data/repositories/authentication_repository.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/general_button.dart';
import '../../../widgets/text_field.dart';

class ConfirmDetailsScreen extends StatefulWidget {
  const ConfirmDetailsScreen({super.key});

  @override
  State<ConfirmDetailsScreen> createState() => _ConfirmDetailsScreenState();
}

class _ConfirmDetailsScreenState extends State<ConfirmDetailsScreen> {
  DateFormat dateFormat = DateFormat('yyyy-MMM-dd');

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<AuthenticationProvider>().getUser());
    
    super.initState();
  }

  final NavigationService navigationService = di<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthenticationProvider>(
        builder: (context, authProvider, _) {
          switch (authProvider.loadingState) {
            case LoadingState.busy:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case LoadingState.error:
              return Center(
                child: Row(
                  children: [
                    const AppText(
                      text: 'An error',
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                      size: 20,
                    ),
                    InkWell(
                      onTap: () =>
                          context.read<AuthenticationRepository>().getUser(),
                      child: const AppText(
                        text: 'Reload',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              );

            // loaded
            case LoadingState.loaded:
              final user = authProvider.user;
              return SingleChildScrollView(
                child: SizedBox(
                  height: context.heightPx,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // BVN
                      AppText(
                        text: 'Almost There...',
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w900,
                        size: context.widthPx * 0.089,
                      ),

                      const VerticalSpace(
                        size: 15,
                      ),

                      RichText(
                        text: TextSpan(
                          style: GoogleFonts.plusJakartaSans(
                            color: AppColors.gunMetal,
                            fontSize: context.widthPx * 0.031,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            const TextSpan(
                                text: 'Please, confirm your details for '),
                            TextSpan(
                              text: user!.bvn,
                              style: GoogleFonts.plusJakartaSans(
                                color: AppColors.primaryColor,
                                fontSize: context.widthPx * 0.031,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const VerticalSpace(
                        size: 20,
                      ),

                      // first name, last name
                      Row(
                        children: [
                          SizedBox(
                            width: context.widthPx * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gender
                                AppText(
                                  text: 'First Name',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),

                                const VerticalSpace(size: 10),

                                AppTextField(
                                  hintText: user.firstName,
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),

                          const HorizontalSpace(size: 10),

                          // Marital Status
                          SizedBox(
                            width: context.widthPx * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Last Name',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),
                                const VerticalSpace(size: 10),
                                AppTextField(
                                  hintText: user.lastName,
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const VerticalSpace(
                        size: 20,
                      ),

                      // phone number text and textfield
                      AppText(
                        text: 'Phone number',
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
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
                        hintText: user.phoneNumber,
                        controller: TextEditingController(),
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.unspecified,
                        readOnly: true,
                      ),

                      const VerticalSpace(
                        size: 20,
                      ),

                      // Gender and Marital Status
                      Row(
                        children: [
                          SizedBox(
                            width: context.widthPx * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gender
                                AppText(
                                  text: 'Gender',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),

                                const VerticalSpace(size: 10),

                                AppTextField(
                                  hintText: user.gender ?? 'Not Available',
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),

                          const HorizontalSpace(size: 10),

                          // Marital Status
                          SizedBox(
                            width: context.widthPx * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'Marital Status',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),
                                const VerticalSpace(size: 10),
                                AppTextField(
                                  hintText:
                                      user.maritalStatus ?? 'Not Available',
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const VerticalSpace(
                        size: 20,
                      ),

                      // DOB and State Of Origin
                      Row(
                        children: [
                          // DOB
                          SizedBox(
                            width: context.widthPx * 0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Gender
                                AppText(
                                  text: 'Date of Birth',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),

                                const VerticalSpace(size: 10),

                                AppTextField(
                                  hintText: dateFormat.format(user.dateOfBirth),
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),

                          const HorizontalSpace(size: 10),

                          // State of Origin
                          SizedBox(
                            width: context.widthPx * 0.44,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: 'State of Origin',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                  size: context.widthPx * 0.035,
                                ),
                                const VerticalSpace(size: 10),
                                AppTextField(
                                  hintText:
                                      user.stateOfOrigin ?? 'Not Available',
                                  controller: TextEditingController(),
                                  textInputType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.unspecified,
                                  readOnly: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const VerticalSpace(
                        size: 20,
                      ),

                      // Address
                      AppText(
                        text: 'Address',
                        color: AppColors.black,
                        fontWeight: FontWeight.w600,
                        size: context.widthPx * 0.035,
                      ),

                      const VerticalSpace(size: 10),

                      AppTextField(
                        hintText: user.address ?? 'Not Available',
                        maxLines: 3,
                        controller: TextEditingController(),
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.unspecified,
                        readOnly: true,
                      ),

                      const SizedBox(
                        height: 35,
                      ),

                      GeneralButton(
                        onPressed: () =>
                            navigationService.pushAndRemoveUntil(RouteName.navbar),
                        buttonTextColor: Colors.white,
                        child: const Text(
                          'Confirm',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: context.widthPx * 0.037),
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
