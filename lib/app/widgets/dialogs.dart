import 'dart:math';
import 'dart:ui';

import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppDialog {
  // modal
  static showAppModal(BuildContext context, Widget widget,
      [Color? backgroundColor]) {
    showModalBottomSheet(
        context: context,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: ((context) => BackdropFilter(filter: ImageFilter.blur(
            sigmaX: 2.0, sigmaY: 2.0),child: widget)));
  }

  // pop dialog
  static showAppDialog(
    BuildContext context,
    Widget widget, {
    double height = 387,
    double width = 335,
  }) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: 2.0, sigmaY: 2.0), // blurs the area underneath the modal
        child: Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16)),
            height: height,
            width: width,
            child: widget,
          ),
        ),
      ),
    );
  }
}

class OnSuccessDialogContent extends StatelessWidget {
  final String subtext;
  final void Function() onDoneCallback;

  const OnSuccessDialogContent({
    required this.subtext,
    required this.onDoneCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: (context.heightPx * 0.5),
      width: context.widthPx,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          // background
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: SvgPicture.asset(
              "assets/images/modal-bg.svg",
              fit: BoxFit.fill,
            ),
          ),

          // inserted widget
          Column(
            children: [
              const VerticalSpace(
                size: 15,
              ),

              // image
              Image.asset("assets/images/yayy.png"),

              const VerticalSpace(
                size: 10,
              ),

              // success
              AppText(
                text: 'Success',
                color: Colors.black,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.065,
              ),

              const VerticalSpace(
                size: 10,
              ),

              // text
              AppText(
                text: subtext,
                color: AppColors.dialogsGrey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 15,
              ),

              // button
              GeneralButton(
                onPressed: onDoneCallback,
                height: context.heightPx * 0.06,
                width: context.widthPx * 0.35,
                borderRadius: 10,
                child: const Text(
                  'Log In',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OnFailDialogContent extends StatelessWidget {
  const OnFailDialogContent({
    Key? key,
    required this.subtext,
    required this.onDoneCallback,
  }) : super(key: key);

  final String subtext;
  final void Function() onDoneCallback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (context.heightPx * 0.35),
      width: context.widthPx,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: SvgPicture.asset(
                "assets/images/modal-bg.svg",
                fit: BoxFit.fill,
                color: AppColors.merlot,
              ),
            ),
          ),

          // inserted widget
          Column(
            children: [
              const VerticalSpace(
                size: 10,
              ),

              // image
              Image.asset("assets/images/oops.png"),

              const VerticalSpace(
                size: 10,
              ),

              // success
              AppText(
                text: 'Oops',
                color: Colors.black,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.065,
              ),

              const VerticalSpace(
                size: 10,
              ),

              // text
              AppText(
                text: subtext,
                color: AppColors.grey,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 15,
              ),

              // button
              GeneralButton(
                onPressed: onDoneCallback,
                height: 40,
                width: 120,
                borderRadius: 10,
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BiometricModal extends StatelessWidget {
  const BiometricModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const AppText(
            text: "Sign In",
            fontWeight: FontWeight.bold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/outline/fingerprint_bare.svg'),
              const HorizontalSpace(
                size: 5,
              ),
              const AppText(text: "Scan your fingerprint"),
            ],
          ),
          const AppText(
            text: "Cancel",
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}


// Image.asset("assets/images/yayy.png"),
