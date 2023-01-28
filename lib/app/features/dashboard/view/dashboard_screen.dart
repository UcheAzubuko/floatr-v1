import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/dashboard/view/widgets/activities_widgets.dart';
import 'package:floatr/app/features/profile/data/model/user_helper.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/route_names.dart';
import '../../../widgets/prompt_widget.dart';
import 'widgets/data_completion_widget.dart';
import 'widgets/highlights_card.dart';
import 'widgets/options_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _dateTime = DateTime.now();

  String get _periodOfDay {
    if (_dateTime.hour >= 16 && _dateTime.hour <= 23) {
      return 'GOOD EVENING';
    } else if (_dateTime.hour >= 12 && _dateTime.hour <= 15) {
      return 'GOOD AFTERNOON';
    }
    return 'GOOD MORNING';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();

    return Scaffold(
      body: Consumer<AuthenticationProvider>(
        builder: (context, provider, _) {
          final user = provider.user;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // greet and profile  pic
                SizedBox(
                  width: context.widthPx,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const VerticalSpace(
                            size: 20,
                          ),
                          // greet
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(SvgAppIcons.icMorningSun),
                              const HorizontalSpace(
                                size: 10,
                              ),
                              Text(_periodOfDay,
                                  style: TextStyles.smallTextPrimary)
                            ],
                          ),

                          const VerticalSpace(size: 4),

                          // name
                          Text(
                            '${user!.firstName} ${user.lastName}',
                            style: TextStyles.largeTextDark,
                          ),
                        ],
                      ),

                      // profile pic
                      InkWell(
                        onTap: () =>
                            navigationService.navigateTo(RouteName.profile),
                        child: CircleAvatar(
                          radius: 23,
                          backgroundImage: NetworkImage(user.photo!.url!),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 10),
                ),

                const VerticalSpace(size: 20),

                PromptWidget(
                  row: Row(
                    children: [
                      SvgPicture.asset(SvgAppIcons.icCaution),
                      const HorizontalSpace(
                        size: 8,
                      ),
                      const Text(
                        'Update your profile to unlock all features!.',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                const VerticalSpace(size: 31),

                // card with progress or card with offers
                // const DebtCard(),

                !UserHelper(user: provider.user!).isFullyOnboarded
                    ? const DataCompletionWidget().paddingOnly(bottom: 30)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const HighlightsCard(),
                          const VerticalSpace(size: 40),

                          // dashboard options
                          SizedBox(
                            width: context.widthPx,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                OptionsCard(
                                  itemName: 'Banks',
                                  assetPath: 'assets/icons/fill/bank-icon.svg',
                                ),
                                OptionsCard(
                                  itemName: 'Cards',
                                  assetPath:
                                      'assets/icons/fill/credit-card.svg',
                                ),
                                OptionsCard(
                                  itemName: 'Schedule',
                                  assetPath:
                                      'assets/icons/fill/time-schedule.svg',
                                ),
                                OptionsCard(
                                  itemName: 'More',
                                  assetPath: 'assets/icons/fill/more-icon.svg',
                                ),
                              ],
                            ),
                          ),

                          const VerticalSpace(size: 40),

                          // recent activities
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recent Activities',
                              style: TextStyles.normalTextDarkF800,
                            ),
                          ),

                          const VerticalSpace(
                            size: 22,
                          ),

                          SizedBox(
                            height: 256,
                            width: context.widthPx,
                            child: const ActivitiesList(),
                          ),
                        ],
                      ),

                // const HighlightsCard(),
              ],
            ).paddingOnly(
              left: 10,
              right: 10,
              top: 40,
            ),
          );
        },
      ),
    );
  }
}
