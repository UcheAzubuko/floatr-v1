import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';

class DisabledButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double? height;
  final Color borderColor;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color buttonTextColor;
  final bool active;
  final Widget child;
  // ignore: use_key_in_widget_constructors
  const DisabledButton({
    required this.onPressed,
    this.width = double.infinity,
    this.height,
    this.foregroundColor,
    required this.child,
    this.backgroundColor = AppColors.disabledBackgroundColor,
    this.buttonTextColor = const Color(0xffFFFFFF),
    this.borderColor = AppColors.disabledBackgroundColor,
    this.active = true,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      textStyle: GoogleFonts.plusJakartaSans(
        textStyle: Theme.of(context).textTheme.bodyText1,
        color: buttonTextColor,
        fontSize: context.widthPx * 0.045,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return SizedBox(
      height: height ?? context.heightPx * 0.07,
      width: width,
      child: ElevatedButton(
        style: style,
        onPressed: null,
        child: child,
      ),
    );
  }
}
