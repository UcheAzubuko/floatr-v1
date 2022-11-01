import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:floatr/app/extensions/sized_context.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  String? Function(String?)? validate;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final VoidCallback? onTap;
  final bool readOnly;

  AppTextField(
      {Key? key,
      this.hintText,
      this.prefixIcon,
      this.obscureText = false,
      this.validate,
      required this.controller,
      this.textInputType,
      this.textInputAction,
      this.maxLines,
      this.onSaved,
      this.onTap,
      this.labelText,
      this.readOnly = false,
      this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.primaryColor,
      obscureText: obscureText,
      validator: validate,
      maxLines: obscureText == true ? 1 : maxLines,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        hintText: hintText,
        labelText: labelText,
        hintStyle: GoogleFonts.plusJakartaSans(
          color: AppColors.grey,
          fontSize: context.widthPx * 0.03,
          fontWeight: FontWeight.w600,
          textStyle: Theme.of(context).textTheme.bodyText1,
        ),

        // const TextStyle(
        //     color: AppColors.grey, fontSize: 14, fontWeight: FontWeight.w400),
        fillColor: AppColors.textFieldBackground.withOpacity(0.4),
        suffixIcon: suffixIcon,
        filled: true,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      onChanged: (value) {},
      onSaved: onSaved,
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
    );
  }
}
