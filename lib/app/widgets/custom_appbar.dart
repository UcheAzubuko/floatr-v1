import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/misc/dependency_injectors.dart';
import '../../core/route/navigation_service.dart';
import '../../core/utils/app_style.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final bool useInAppArrow;
  final bool shrinkAppBar;

  @override
  final Size preferredSize;

  CustomAppBar(
      {Key? key,
      this.title,
      this.useInAppArrow = false,
      this.shrinkAppBar = false})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();
    return shrinkAppBar
        ? PreferredSize(
            preferredSize: const Size.fromHeight(0), // Set this height
            child: Container(),
          )
        : AppBar(
            // your customization here
            title: Text(
              title ?? '',
              style: TextStyles.normalTextDarkF800,
            ),
            automaticallyImplyLeading: true,
            leading: InkWell(
              onTap: () => navigationService.maybePop(),
              child: SvgPicture.asset(
                  useInAppArrow
                      ? SvgAppIcons.icArrowNormalLeft
                      : 'assets/icons/fill/arrow-left.svg',
                  height: context.heightPx * 0.02,
                  width: context.widthPx * 0.02,
                  fit: BoxFit.scaleDown),
            ),
            centerTitle: false,
          );
  }
}
