import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class PageViewToggler extends StatelessWidget {
  const PageViewToggler(
      {Key? key, required this.togglePosition, required this.viewName})
      : super(key: key);

  final TogglePosition togglePosition;
  final List<String> viewName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.widthPx,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: AppColors.primaryColorLight,
          borderRadius: BorderRadius.circular(12)),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: viewName[1] == 'Payback Options' &&
                        togglePosition == TogglePosition.left
                    ? 28
                    : 28,
                left: 65),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  viewName[0],
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
                if (viewName[1] == 'Payback Options') ...[
                  const SizedBox(
                    width: 135,
                  ),
                ] else ...[
                  const SizedBox(
                    width: 145,
                  ),
                ],
                // else if(viewName[1] == 'Schedule')...[
                //   SizedBox(width: 140,)
                // ],
                Text(
                  viewName[1],
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
            alignment: togglePosition == TogglePosition.left
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
                width: context.widthPx * 0.5,
                height: 32,
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  togglePosition == TogglePosition.left
                      ? viewName[0]
                      : viewName[1],
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold),
                ))),
          ),
        ],
      ),
    );
  }
}

enum TogglePosition { left, right }
