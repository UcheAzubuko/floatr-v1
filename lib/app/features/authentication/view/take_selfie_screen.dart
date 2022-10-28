import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';

class TakeSelefieScreen extends StatefulWidget {
  const TakeSelefieScreen({super.key});

  @override
  State<TakeSelefieScreen> createState() => _TakeSelefieScreenState();
}

class _TakeSelefieScreenState extends State<TakeSelefieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Center Photo Circle
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(400))),
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
                color: Colors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 20,
              ),

              // conditions
              Container(
                height: context.heightPx * 0.12,
                width: context.widthPx * 3,
                decoration: BoxDecoration(
                    color: AppColors.lightYellow,
                    border: Border.all(color: AppColors.yellow),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),

              const VerticalSpace(
                size: 40,
              ),

              // capture button

              GeneralButton(
                onPressed: () {},
                width: context.widthPx * 0.17,
                height: context.heightPx * 0.079,
                child: const Icon(Icons.abc),
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}
