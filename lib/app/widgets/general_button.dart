import 'package:floatr/app/widgets/app_text.dart';
import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class GeneralButton extends StatelessWidget {
  final Function onPressed;
  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;
  final Color? foregroundColor;
  final Color buttonTextColor;
  final bool active;
  final bool isLoading;
  final Widget child;
  final Color loadingColor;
  // ignore: use_key_in_widget_constructors
  const GeneralButton(
      {required this.onPressed,
      this.width = double.infinity,
      this.height = 50,
      this.foregroundColor,
      this.backgroundColor = AppColors.primaryColor,
      required this.child,
      this.buttonTextColor = const Color(0xffFFFFFF),
      this.borderColor = AppColors.primaryColor,
      this.active = true,
      this.loadingColor = Colors.white,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        textStyle: TextStyle(fontSize: 20, color: buttonTextColor),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(15)));

    return SizedBox(
        height: height,
        width: width,
        child: ElevatedButton(
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
                          )),
                      
                       AppText(
                          text: 'Please wait...', color: loadingColor, size: 15)
                    ],
                  )
                : child));
  }
}
