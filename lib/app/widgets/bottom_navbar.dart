import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/features/dashboard/view/dashboard_loan_details.dart';
import 'package:floatr/app/features/loan/providers/loan_provider.dart';
import 'package:floatr/app/features/loan/view/screens/loan_application_screen.dart';
// import 'package:floatr/app/features/loan/view/screens/nav_loan_application_screen.dart';
import 'package:floatr/app/features/profile/data/model/user_helper.dart';
import 'package:floatr/app/features/profile/view/screens/profile_views/cards_banks_screen.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_style.dart';
import '../features/dashboard/view/dashboard_screen.dart';
import '../features/profile/view/screens/profile_screen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loan = context.read<LoanProvider>();
    final user = context.read<AuthenticationProvider>().user;
    final loanResponse = loan.loansResponse;
    final isUserEligible =
        !(user!.loan!.hasPendingApplication! || user.loan!.hasSettlingLoan!);
    Widget getViewForIndex(int index) {
      switch (index) {
        case 0:
          return const DashboardScreen();
        case 1:
          return isUserEligible
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 60),
                    child: EligibleLenderView(
                      loan: loanResponse!.loans[0],
                      isFromNav: true,
                    ),
                  ),
                )
              : const SingleChildScrollView(
                  child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10,),
                  child: SafeArea(child: DashboardLoanDetailSchedule()),
                ));
        case 2:
          return const BottomNavCardView();
        case 3:
          return const ProfileScreen();

        default:
          return const DashboardScreen();
      }
    }

    void setCurrentTabTo({required int newTabIndex}) {
      setState(() {
        currentTabIndex = newTabIndex;
      });
    }

    return Scaffold(
        // backgroundColor: ImpactlyAppColors.backgroundColor,
        body: getViewForIndex(currentTabIndex),
        // extendBodyBehindAppBar: true,
        // extendBody: true,
        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              // sets the background color of the `BottomNavigationBar`
              canvasColor: Colors.white,
              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
              // primaryColor: AppColors.white,
              // backgroundColor: Colors.transparent,
            ),
            child: Consumer<AuthenticationProvider>(
              builder: (context, provider, _) {
                return BottomNavigationBar(
                  selectedFontSize: 0,
                  unselectedFontSize: 0,
                  unselectedItemColor: Colors.white,
                  selectedLabelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  // iconSize: 15,
                  type: BottomNavigationBarType.fixed,
                  onTap: (newTab) {
                    // print(newTab);
                    !UserHelper(user: provider.user!).isFullyOnboarded
                        ? null
                        : setCurrentTabTo(newTabIndex: newTab);
                  },
                  currentIndex: currentTabIndex,
                  items: <BottomNavigationBarItem>[
                    // dashboard
                    BottomNavigationBarItem(
                      icon: BottomItemIcon(
                        color: currentTabIndex == 0
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        assetName: 'assets/icons/outline/home.svg',
                        height: 24,
                      ),
                      label: '',
                    ),

                    // leaderboard
                    BottomNavigationBarItem(
                      icon: BottomItemIcon(
                        color: currentTabIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        assetName: 'assets/icons/outline/wallet-nav.svg',
                        height: 24,
                      ),
                      label: '',
                    ),

                    // contest
                    BottomNavigationBarItem(
                      icon: BottomItemIcon(
                        color: currentTabIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.grey,
                        assetName: 'assets/icons/outline/card-nav.svg',
                        height: 24,
                      ),
                      label: '',
                    ),

                    // // wallet
                    // BottomNavigationBarItem(
                    //   icon: BottomItemIcon(
                    //     color:
                    //         currentTabIndex == 3 ? AppColors.gold : AppColors.white,
                    //     assetName: SvgAppIcons.icWallet,
                    //   ),
                    //   label: 'Wallet',
                    // ),

                    // profile
                    BottomNavigationBarItem(
                      icon: BottomItemIcon(
                        color: currentTabIndex == 3 ? null : Colors.grey,
                        assetName: currentTabIndex == 3
                            ? 'assets/icons/outline/user-nav.svg'
                            : 'assets/icons/outline/user-nav.svg',
                        height: 24,
                      ),
                      label: '',
                    ),
                  ],
                  selectedItemColor: Colors.red,
                );
              },
            )));
  }
}

class BottomNavCardView extends StatelessWidget {
  const BottomNavCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(
            size: 100,
          ),
          Row(
            children: [
              SvgPicture.asset(
                "assets/images/main-logo.svg",
                height: 30,
                fit: BoxFit.fill,
              ),

              Text(
                'floatr',
                style: TextStyles.normalTextDarkF800,
              ),

              // tit;
            ],
          ).paddingOnly(left: 15),

          // title
          Text(
            'My Cards',
            style: TextStyles.largeTextDark,
          ).paddingOnly(left: 15),

          const VerticalSpace(
            size: 9,
          ),

          Text(
            'Choose your default card and make changes\nto your card.',
            style: TextStyles.smallTextGrey14Px,
          ).paddingOnly(left: 15),

          const CardView().paddingSymmetric(horizontal: 5),

          const VerticalSpace(
            size: 9,
          ),
        ],
      ),
    );
  }
}

class BottomItemIcon extends StatelessWidget {
  const BottomItemIcon(
      {Key? key, this.color, required this.assetName, this.height = 18})
      : super(key: key);

  final Color? color;
  final String assetName;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7.0),
      child: SizedBox(
        height: height,
        // padding: const EdgeInsets.only(bottom: 5),
        child: SvgPicture.asset(
          assetName,
          // width: 23.0,
          // height: 15,
          color: color,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
