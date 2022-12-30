import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../widgets/custom_appbar.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen({super.key, required this.image});

  final XFile image;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  late File _imageFile;

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const VerticalSpace(
                size: 110,
              ),

              // center photo circle
              DottedBorder(
                strokeWidth: 2,
                color: Colors.green,
                padding: const EdgeInsets.all(10),
                dashPattern: const [2, 10, 2, 0],
                radius: const Radius.circular(400),
                borderType: BorderType.Circle,
                child: Container(
                  height: 232,
                  width: 232,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: AppColors.lightGreen,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  child: Transform.rotate(
                      angle: -1.5708,
                      child: Image.file(
                        File(widget.image.path),
                        fit: BoxFit.fill,
                      )),
                ),
              ),

              const VerticalSpace(
                size: 70,
              ),

              InkWell(
                onTap: () => navigationService.pop(),
                child: Column(
                  children: [
                    AppText(
                      text: 'Retake Selfie?',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      size: context.widthPx * 0.031,
                    ),
                    Container(
                      height: 0.5,
                      width: 85,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),

              const VerticalSpace(
                size: 70,
              ),

              Consumer<AuthenticationProvider>(
                  builder: (context, authProvider, __) {
                return GeneralButton(
                    height: 55,
                    onPressed: () => _handleImageUpload(authProvider, File(widget.image.path)),
                    isLoading: authProvider.loadingState == LoadingState.busy,
                    child: const Text(
                      'VERIFY',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ));
              }),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }

  _handleImageUpload(AuthenticationProvider authProvider, File imageFile) async{
    authProvider.updateImage(imageFile);
    await authProvider.uploadimage();
  }
}
