import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../widgets/app_text.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // getstarted
            AppText(
              text: 'Getting Started',
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.085,
            ),

            // sub text
             AppText(
              text: 'Create an Account to continue!',
              color: AppColors.grey,
              fontWeight: FontWeight.w900,
              size: context.widthPx * 0.02,
            )

            // email text and textfield

            // phone number text and textfield

            // password text and textfield

            // confirm password text and textfield

            // dob text and textfield
          ],
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }
}