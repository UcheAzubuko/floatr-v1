import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double? height;
  final double borderRadius;
  final Color borderColor;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color buttonTextColor;
  final bool active;
  final bool isLoading;
  final Widget child;
  final Color loadingColor;
  // ignore: use_key_in_widget_constructors
  const GeneralButton({
    required this.onPressed,
    this.width = double.infinity,
    this.height,
    this.foregroundColor,
    this.borderRadius = 15,
    this.backgroundColor = AppColors.primaryColor,
    required this.child,
    this.buttonTextColor = const Color(0xffFFFFFF),
    this.borderColor = AppColors.primaryColor,
    this.active = true,
    this.loadingColor = Colors.white,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      textStyle: GoogleFonts.plusJakartaSans(
        color: buttonTextColor,
        fontSize: context.widthPx * 0.045,
        fontWeight: FontWeight.w700,
        textStyle: Theme.of(context).textTheme.bodyLarge,
      ),
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );

    return SizedBox(
      height: height ?? context.heightPx * 0.07,
      width: width,
      child: TextButton(
          style: style,
          onPressed: () {
            onPressed();
          },
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: loadingColor,
                        strokeWidth: 1,
                      ),
                    ),
                    const HorizontalSpace(
                      size: 15,
                    ),
                    AppText(
                        text: 'Please wait...', color: loadingColor, size: 15),
                  ],
                )
              : child),
    );
  }
}
