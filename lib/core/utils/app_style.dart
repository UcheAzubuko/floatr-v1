import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle smallTextPrimary = const TextStyle(
    fontSize: 10,
    color: AppColors.primaryColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle smallTextDark = const TextStyle(
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle smallerTextDark = const TextStyle(
    fontSize: 8,
    color: AppColors.black,
    fontWeight: FontWeight.w600,
  );

  static TextStyle largeTextDark = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.black,
  );

  static TextStyle largeTextPrimary = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryColor,
  );

  static TextStyle normalTextDarkF800 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
  );

  static TextStyle normalTextDarkF600 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
