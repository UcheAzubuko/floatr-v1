import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/dashboard/providers/dashboard_provider.dart';
import 'package:floatr/app/features/dashboard/view/widgets/activities_widgets.dart';
import 'package:floatr/app/features/dashboard/view/widgets/debt_card.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/features/profile/data/model/user_helper.dart';
import 'package:floatr/core/providers/base_provider.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:floatr/core/utils/app_style.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/misc/helper_functions.dart';
import '../../../../core/route/route_names.dart';
import '../../../widgets/pageview_toggler.dart';
import '../../../widgets/prompt_widget.dart';
import '../../profile/view/screens/profile_views/cards_banks_screen.dart';
import 'widgets/data_completion_widget.dart';
import 'widgets/highlights_card.dart';
import 'widgets/options_card.dart';
import 'widgets/pending_loan_application_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();

    return Scaffold(
      body: Consumer2<AuthenticationProvider, LoanProvider>(
        builder: (context, authprovider, loanProvider, _) {
          final user = authprovider.user;

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
                              Text(periodOfDay,
                                  style: TextStyles.smallTextPrimary)
                            ],
                          ),

                          const VerticalSpace(size: 4),

                          // name
                          Text(
                            '${user!.firstName}',
                            style: TextStyles.largeTextDark,
                          ),
                        ],
                      ),

                      // profile pic
                      InkWell(
                        onTap: () => UserHelper(user: user).isFullyOnboarded
                            ? navigationService.navigateTo(RouteName.profile)
                            : () {},
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
                        'Update your profile to unlock all features!',
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

                !UserHelper(user: authprovider.user!).isFullyOnboarded
                    ? const DataCompletionWidget().paddingOnly(bottom: 30)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (user.loan!.hasSettlingLoan! &&
                              user.loan!.hasActiveApplication!) ...[
                            const DebtCard()
                          ] else if (user.loan!.hasPendingApplication! &&
                              user.loan!.hasActiveApplication!) ...[
                            const PendingLoanApplicationCard(),
                          ] else ...[
                            const HighlightsCard(),
                          ],

                          const VerticalSpace(size: 40),

                          // dashboard options
                          SizedBox(
                            width: context.widthPx,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                OptionsCard(
                                  itemName: 'Banks',
                                  assetPath: 'assets/icons/fill/bank-icon.svg',
                                  onPressed: () => navigationService.navigateTo(
                                      RouteName.cardsBanks,
                                      arguments: CardsBanksArguments(
                                          bottomScreenName: 'Dashboard',
                                          togglePosition:
                                              TogglePosition.right)),
                                ),
                                OptionsCard(
                                    itemName: 'Cards',
                                    assetPath:
                                        'assets/icons/fill/credit-card.svg',
                                    onPressed: () => navigationService
                                        .navigateTo(RouteName.cardsBanks,
                                            arguments: CardsBanksArguments(
                                                bottomScreenName: 'Dashboard',
                                                togglePosition:
                                                    TogglePosition.left))),
                                OptionsCard(
                                  itemName: 'Schedule',
                                  assetPath:
                                      'assets/icons/fill/time-schedule.svg',
                                  onPressed: () => Fluttertoast.showToast(
                                      msg: "Coming soon!"),
                                ),
                                OptionsCard(
                                  itemName: 'More',
                                  assetPath: 'assets/icons/fill/more-icon.svg',
                                  onPressed: () => Fluttertoast.showToast(
                                      msg: "Coming soon!"),
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

                          Consumer<DashboardProvider>(
                            builder: (context, provider, _) {
                              return SizedBox(
                                height: 256,
                                width: context.widthPx,
                                child: _showActitvity(provider),
                              );
                            },
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

  Widget _showActitvity(DashboardProvider dashboardProvider) {
    if (dashboardProvider.loadingState == LoadingState.busy) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (dashboardProvider.loadingState == LoadingState.loaded) {
      if (dashboardProvider.activiesResponse != null) {
        if (dashboardProvider.activiesResponse!.activities.isEmpty) {
          return const NoActivityView();
        } else {
          return ActivitiesList(
            activities: dashboardProvider.activiesResponse!.activities,
          );
        }
      }
    }
    return const Center(
      child: Text('Could not get activities'),
    );
  }
}
