import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/view/display_picture_screen.dart';
import 'package:floatr/app/features/camera/camara_view.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/route/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:provider/provider.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';
import '../../camera/camera_provider.dart';

class TakeSelefieScreen extends StatefulWidget {
  const TakeSelefieScreen({super.key});

  @override
  State<TakeSelefieScreen> createState() => _TakeSelefieScreenState();
}

class _TakeSelefieScreenState extends State<TakeSelefieScreen>
    with WidgetsBindingObserver {
  final NavigationService navigationService = di<NavigationService>();
  CameraController? controller;

  bool _canProcess = true;
  bool _isBusy = false;
  bool _canTakePicture = false;

  final _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableClassification: true,
      enableTracking: true,
    ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _canProcess = false;
    _faceDetector.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // center photo circle
              DottedBorder(
                strokeWidth: 2,
                color: _canTakePicture ? Colors.green : AppColors.red,
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
                      color: _canTakePicture ? Colors.green : AppColors.red,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  child: CameraView(
                    initialDirection: CameraLensDirection.front,
                    onImage: (inputImage) {
                      processImage(inputImage);
                    },
                  ),
                ),
              ),

              const VerticalSpace(
                size: 20,
              ),

              // align your face
              AppText(
                text: 'Align your face',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w900,
                size: context.widthPx * 0.065,
              ),

              const VerticalSpace(
                size: 20,
              ),

              // align face text
              AppText(
                text: '''Align your face to the center of the selfie area
                                       and capture.''',
                color: AppColors.black,
                fontWeight: FontWeight.w600,
                size: context.widthPx * 0.031,
              ),

              const VerticalSpace(
                size: 30,
              ),

              // conditions
              Container(
                height: context.heightPx * 0.12,
                width: context.widthPx * 3,
                decoration: BoxDecoration(
                  color: AppColors.lightYellow,
                  border: Border.all(color: AppColors.yellow),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topCenter,
                        child: SvgPicture.asset(
                            'assets/icons/outline/selfie-caution.svg'),
                      ).paddingOnly(right: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const <Widget>[
                          AppText(
                            text: '• Make sure you are well lit.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            size: 12,
                          ),
                          AppText(
                            text: '• Clearly show your face and ears.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            size: 12,
                          ),
                          AppText(
                            text: '• Keep your phone vertical.',
                            color: AppColors.black,
                            fontWeight: FontWeight.w400,
                            size: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const VerticalSpace(
                size: 40,
              ),

              // capture button

              GeneralButton(
                backgroundColor: _canTakePicture
                    ? AppColors.primaryColor
                    : AppColors.primaryColorLight,
                onPressed: () async {
                  final controller =
                      context.read<CameraProvider>().cameraController!;

                  if (_canTakePicture) {
                    await controller.stopImageStream();

                    controller.takePicture().then((value) {
                      log('Picture taken ${value.path}');
                      navigationService.navigateReplacementTo(
                          RouteName.displayPicture,
                          arguments: DisplayImageArguments(file: value, imageType: ImageType.selfie));
                    });
                  }
                },
                width: 56,
                height: 56,
                child: SvgPicture.asset(
                  'assets/icons/outline/Camera.svg',
                  // height: 40,
                  fit: BoxFit.fill,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ).paddingSymmetric(horizontal: context.widthPx * 0.037),
    );
  }

  Future<void> processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    // setState(() {
    //   _text = '';
    // });
    final faces = await _faceDetector.processImage(inputImage);
    if (inputImage.inputImageData?.size != null &&
        inputImage.inputImageData?.imageRotation != null) {
      if (faces.length == 1) {
        log('Found face!');
        setState(() {
          // _faceStatusColor = Colors.green;
          _canTakePicture = true;
        });
      } else {
        setState(() {
          // _faceStatusColor = Colors.red;
          _canTakePicture = false;
        });
      }
    } else {
      //Todo: Trigger call if more than one face.
      for (final face in faces) {
        // text += 'face: ${face.boundingBox}\n\n';

      }
      // _text = text;

      // _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
