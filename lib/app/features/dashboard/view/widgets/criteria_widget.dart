
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/enums.dart';

class CriteriaWidget extends StatelessWidget {
  const CriteriaWidget(
      {Key? key, required this.criteriaTitle, required this.criteriaState})
      : super(key: key);

  final String criteriaTitle;
  final CriteriaState criteriaState;

  Widget prefferedIcon(CriteriaState criteriaState) {
    switch (criteriaState) {
      case CriteriaState.done:
        return SvgPicture.asset(
          'assets/icons/fill/tick-circle.svg',
          color: Colors.green,
        );
      case CriteriaState.notDone:
        return SvgPicture.asset(
          'assets/icons/outline/tick-circle.svg',
          color: Colors.grey,
        );
      case CriteriaState.pending:
        return SvgPicture.asset(
          'assets/icons/outline/tick-circle-broken.svg',
          color: Colors.green,
        );
      default:
        return SvgPicture.asset(
          'assets/icons/fill/tick-circle.svg',
          color: Colors.green,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          criteriaTitle,
          style: TextStyles.smallTextDark14Px,
        ),
        CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white,
            child: prefferedIcon(criteriaState)),
      ],
    );
  }
}
