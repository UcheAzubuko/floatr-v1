import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/images.dart';
import '../../../../../core/utils/spacing.dart';

class PendingLoanApplicationCard extends StatelessWidget {
  const PendingLoanApplicationCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationProvider>().user;
    return Container(
      height: 416,
      width: context.widthPx,
      decoration: BoxDecoration(
        color: AppColors.primaryColorLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // bg overlay
          SvgPicture.asset(
            width: context.widthPx,
            SvgImages.dashboardAuthBackground,
            fit: BoxFit.fitWidth,
            clipBehavior: Clip.hardEdge,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpace(size: 48),
                  SvgPicture.asset(
                    "assets/images/main-logo.svg",
                    height: 24,
                  ),
                  const VerticalSpace(size: 12),
                  Text(
                    'Hi ${user!.firstName},',
                    style: TextStyles.smallTextDark,
                  ),
                  const VerticalSpace(size: 12),
                  Text(
                    '''Your application is currently \npending approval!''',
                    style: TextStyles.largeTextDarkPoppins,
                  ),
                  const VerticalSpace(
                    size: 50,
                  ),
                  Center(
                      child: GeneralButton(
                    onPressed: () {},
                    width: 180,
                    height: 35,
                    borderRadius: 10,
                    child: const Text(
                      'VIEW DETAILS',
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ))
                ],
              ).paddingOnly(left: 26, right: 26),
              const VerticalSpace(size: 48),
            ],
          ),
        ],
      ),
    );
  }
}
