import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard(
      {Key? key,
      required this.assetPath,
      this.onPressed,
      required this.itemName})
      : super(key: key);

  final String assetPath;
  final Function()? onPressed;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            height: 66,
            width: 66,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColorLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(assetPath),
          ),
          Text(
            itemName,
            style: TextStyles.smallTextDark,
          )
        ],
      ),
    );
  }
}
