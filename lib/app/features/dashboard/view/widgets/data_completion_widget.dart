import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/misc/dependency_injectors.dart';
import '../../../../../core/route/navigation_service.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/enums.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';
import '../../../../widgets/dialogs.dart';
import '../../../../widgets/general_button.dart';
import '../../../authentication/providers/authentication_provider.dart';
import '../../../profile/data/model/user_helper.dart';
import '../../../profile/view/screens/edit_profile.dart';
import '../../../profile/view/screens/profile_screen.dart';
import 'criteria_widget.dart';

class DataCompletionWidget extends StatefulWidget {
  const DataCompletionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DataCompletionWidget> createState() => _DataCompletionWidgetState();
}

class _DataCompletionWidgetState extends State<DataCompletionWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();

    return Consumer<AuthenticationProvider>(
      builder: (context, authProvider, _) {
        UserHelper userHelper = UserHelper(user: authProvider.user!);

        return Container(
          height: 576,
          width: context.widthPx,
          // color: AppColors.primaryColor,
          // padding: const EdgeInsets.all(26),
          decoration: BoxDecoration(
            color: AppColors.primaryColorLight,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Stack(
            children: [
              // bg overlay
              SvgPicture.asset(
                width: context.widthPx,
                SvgImages.dashboardUnAuthBackground,
                fit: BoxFit.fitWidth,
                clipBehavior: Clip.hardEdge,
              ),

              Padding(
                padding: const EdgeInsets.all(26),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // floatr logo
                    SvgPicture.asset(
                      "assets/images/main-logo.svg",
                      height: 24,
                      // fit: BoxFit.cover,
                    ),

                    const VerticalSpace(
                      size: 10,
                    ),

                    // ready.. set
                    Text(
                      'Ready... Set...',
                      style: TextStyles.largeTextDarkPoppins600,
                    ),

                    const VerticalSpace(
                      size: 10,
                    ),

                    // all cap
                    Text(
                      '''Your Floatr journey starts now. Complete your \nprofile to gain access to loan offers just for you.''',
                      style: TextStyles.smallTextDark,
                    ),

                    const VerticalSpace(
                      size: 34,
                    ),

                    // personal
                    InkWell(
                      onTap: () => navigationService.navigateToRoute(
                          const EditProfileScreen(
                              editProfileView: EditProfile.personalDetails)),
                      child: CriteriaWidget(
                        criteriaTitle: 'Personal Details',
                        criteriaState: userHelper.isPersonalDetailsComplete
                            ? CriteriaState.done
                            : CriteriaState.pending,
                      ),
                    ),

                    const VerticalSpace(
                      size: 20,
                    ),

                    // gov
                    InkWell(
                      onTap: () => AppDialog.showAppModal(
                          context, const GovIDModalView(), Colors.transparent),
                      child: CriteriaWidget(
                        criteriaTitle: 'Government Issued ID',
                        criteriaState: userHelper.isIdDataComplete
                            ? CriteriaState.pending
                            : CriteriaState.notDone,
                      ),
                    ),

                    const VerticalSpace(
                      size: 20,
                    ),

                    // res addy
                    InkWell(
                      onTap: () => navigationService.navigateToRoute(
                          const EditProfileScreen(
                              editProfileView: EditProfile.residentialAddress)),
                      child: CriteriaWidget(
                        criteriaTitle: 'Residential Address',
                        criteriaState: userHelper.isAddressComplete
                            ? CriteriaState.done
                            : CriteriaState.notDone,
                      ),
                    ),

                    const VerticalSpace(
                      size: 20,
                    ),

                    // employment details
                    InkWell(
                      onTap: () => navigationService.navigateToRoute(
                          const EditProfileScreen(
                              editProfileView: EditProfile.employmentDetails)),
                      child: CriteriaWidget(
                        criteriaTitle: 'Employment Details',
                        criteriaState: userHelper.isEmployerDetailsComplete
                            ? CriteriaState.done
                            : CriteriaState.notDone,
                      ),
                    ),

                    const VerticalSpace(
                      size: 20,
                    ),

                    // next of kin
                    InkWell(
                      onTap: () => navigationService.navigateToRoute(
                          const EditProfileScreen(
                              editProfileView: EditProfile.nextOfKin)),
                      child: CriteriaWidget(
                        criteriaTitle: 'Next of Kin',
                        criteriaState: userHelper.isNextOfKinComplete
                            ? CriteriaState.done
                            : CriteriaState.notDone,
                      ),
                    ),

                    const VerticalSpace(
                      size: 34,
                    ),

                    // button
                    Consumer<AuthenticationProvider>(
                      builder: (context, provider, _) {
                        return GeneralButton(
                            height: 48,
                            width: context.widthPx,
                            borderRadius: 12,
                            backgroundColor: userHelper.isFullyOnboarded
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight.withOpacity(0.4),
                            borderColor: userHelper.isFullyOnboarded
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight.withOpacity(0.1),
                            onPressed: () {},
                            // _proceed(TransactionPinState.initial),
                            // userHelper.isFullyOnboarded()
                            //     ? provider.updateTempCompletion(true)
                            //     : null,
                            child: const AppText(
                              text: 'LET\'S GO!',
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              size: 14,
                            ));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
