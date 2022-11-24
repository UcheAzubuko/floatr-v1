import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    Key? key,
    this.height = 149,
    this.width = 347,
    required this.infoTitle,
    required this.child,
    this.onTap,
  }) : super(key: key);

  final double height;
  final double width;
  final String infoTitle;
  final Widget child;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightGrey300, width: 2),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              infoTitle,
              style: TextStyles.normalTextDarkF800,
            ).paddingSymmetric(horizontal: 16, vertical: 16),
            Container(
              // color: AppColors.black,
              height: 2,
              width: context.widthPx,
              decoration: const BoxDecoration(
                color: AppColors.lightGrey300,
              ),
            ),
            SizedBox(
                height: height - 58,
                child: child.paddingSymmetric(horizontal: 16)),
          ],
        ),
      ),
    );
  }
}
