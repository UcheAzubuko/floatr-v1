import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';

class TakeSelefieScreen extends StatefulWidget {
  const TakeSelefieScreen({super.key});

  @override
  State<TakeSelefieScreen> createState() => _TakeSelefieScreenState();
}

class _TakeSelefieScreenState extends State<TakeSelefieScreen> {
  final NavigationService navigationService = di<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // center photo circle
              DottedBorder(
                strokeWidth: 2,
                color: AppColors.primaryColor,
                padding: const EdgeInsets.all(10),
                dashPattern: const [2, 10, 2, 0],
                radius: const Radius.circular(400),
                borderType: BorderType.Circle,
                child: Container(
                  height: context.heightPx * 0.32,
                  width: context.widthPx * 0.68,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                ),
              ),

              const VerticalSpace(
                size: 20,
              ),

              // align your face
              AppText(
                text: 'Align your face',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.065,
              ),

              const VerticalSpace(
                size: 20,
              ),

              // align face text
              AppText(
                text: '''Align your face to the center of the selfie area
                                       and capture.''',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 30,
              ),

              // conditions
              Container(
                height: context.heightPx * 0.12,
                width: context.widthPx * 3,
                decoration: BoxDecoration(
                  color: AppColors.lightYellow,
                  border: Border.all(color: AppColors.yellow),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.widthPx * 0.1,
                      vertical: context.heightPx * 0.02),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                            'assets/icons/outline/selfie-caution.svg'),
                      ),
                      SizedBox(
                        width: context.widthPx * 0.06,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          AppText(
                            text: '●   Make sure you are well lit.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            size: context.widthPx * 0.031,
                          ),
                          AppText(
                            text: '●   Clearly show your face and ears.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            size: context.widthPx * 0.031,
                          ),
                          AppText(
                            text: '●   Keep your phone vertical.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            size: context.widthPx * 0.031,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const VerticalSpace(
                size: 40,
              ),

              // capture button

              GeneralButton(
                onPressed: () =>
                    navigationService.navigateTo(RouteName.confirmDetails),
                width: context.widthPx * 0.17,
                height: context.heightPx * 0.079,
                child: SvgPicture.asset(
                  'assets/icons/outline/Camera.svg',
                  height: 40,
                  fit: BoxFit.fill,
                  color: AppColors.wierdBlack,
                ),
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
