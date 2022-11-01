
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/misc/dependency_injectors.dart';
import '../../core/route/navigation_service.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;

  @override
  final Size preferredSize;

  CustomAppBar({Key? key, this.title})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final NavigationService navigationService = di<NavigationService>();
    return AppBar(
      // your customization here
      title: Text(title ?? ''),
      leading: InkWell(
        onTap: () => navigationService.maybePop(),
        child: SvgPicture.asset('assets/icons/fill/arrow-left.svg',
            height: context.heightPx * 0.02, width: context.widthPx * 0.02, fit: BoxFit.scaleDown),
      ),
      centerTitle: true,
      // backgroundColor: Colors.black54,
    );
  }
}
