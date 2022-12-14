import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class PromptWidget extends StatelessWidget {
  const PromptWidget({Key? key, required this.row}) : super(key: key);

  final Row row;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPx,
      padding: const EdgeInsets.all(8),
      // height: 35,
      decoration: BoxDecoration(
          color: AppColors.lightYellow03,
          borderRadius: BorderRadius.circular(12)),
      child: row,
    );
  }
}