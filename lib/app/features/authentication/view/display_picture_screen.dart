import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/providers/authentication_provider.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/navigation_service.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/providers/base_provider.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/images.dart';
import '../../../widgets/custom_appbar.dart';

class DisplayPictureScreen extends StatefulWidget {
  const DisplayPictureScreen(
      {super.key, required this.image, required this.imageType, this.documentType});

  final XFile image;
  final ImageType imageType;
  final DocumentType? documentType;

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
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
              widget.imageType == ImageType.selfie
                  ? DottedBorder(
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
                        child: Image.file(
                          File(widget.image.path),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          width: context.widthPx,
                          SvgImages.documentSnapShotFrame,
                          fit: BoxFit.fill,
                          height: 270,
                          color: AppColors.primaryColor,
                        ),
                        Container(
                          height: 240,
                          width: context.widthPx * 0.86,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                          ),
                          child: Image.file(
                            File(widget.image.path),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),

              const VerticalSpace(
                size: 70,
              ),

              InkWell(
                onTap: () => navigationService.navigateReplacementTo(
                    widget.imageType == ImageType.selfie
                        ? RouteName.takeSelfie
                        : RouteName.snapDocument),
                child: Column(
                  children: [
                    AppText(
                      text: widget.imageType == ImageType.selfie
                          ? 'Retake Selfie?'
                          : 'Retake Document Snapshot',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      size: context.widthPx * 0.031,
                    ),
                    Container(
                      height: 0.5,
                      width: widget.imageType == ImageType.selfie ? 85 : 170,
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
                    onPressed: () => _handleImageUpload(
                        authProvider, File(widget.image.path)),
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

  _handleImageUpload(
      AuthenticationProvider authProvider, File imageFile, [DocumentType documentType = DocumentType.driverLicense]) async {
    // authProvider.updateImage(imageFile);
    context.read<AuthenticationProvider>()
      ..updateImage(imageFile)
      ..uploadimage(
          context,
          widget.imageType == ImageType.selfie
              ? ImageType.selfie
              : ImageType.document, documentType);
    // await authProvider.uploadimage();
  }
}

class DisplayImageArguments {
  final XFile file;
  final ImageType imageType;
  final DocumentType? documentType;
  DisplayImageArguments(
      {required this.file,
      required this.imageType,
      this.documentType});
}
