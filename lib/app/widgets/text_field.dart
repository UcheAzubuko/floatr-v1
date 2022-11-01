import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final int? maxLines;
  final Widget? suffixIcon;
  final bool obscureText;
  String? Function(String?)? validate;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final void Function(String?)? onSaved;

  AppTextField(
      {Key? key,
      required this.hintText,
      this.prefixIcon,
      this.obscureText = false,
      this.validate,
      required this.controller,
      required this.textInputType,
      required this.textInputAction,
      this.maxLines,
      this.onSaved,
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
        hintStyle: const TextStyle(
          color: AppColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400
        ),
        fillColor: AppColors.grey.withOpacity(0.15),
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
    );
  }
}
