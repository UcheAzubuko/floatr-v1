import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/authentication/view/display_picture_screen.dart';
import 'package:floatr/app/widgets/app_snackbar.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/misc/dependency_injectors.dart';
import '../../../../core/route/navigation_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/spacing.dart';
import '../../../widgets/app_text.dart';
import '../../../widgets/custom_appbar.dart';

class TakeSelefieScreen extends StatefulWidget {
  const TakeSelefieScreen({super.key});

  @override
  State<TakeSelefieScreen> createState() => _TakeSelefieScreenState();
}

class _TakeSelefieScreenState extends State<TakeSelefieScreen>
    with WidgetsBindingObserver {
  final NavigationService navigationService = di<NavigationService>();
  CameraController? controller;
  // late List<CameraDescription>? _cameras;

  // Future<void> initAvailableCameras() async {
  //   _cameras = await availableCameras();
  // }

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // initAvailableCameras();
    // });

    availableCameras().then((value) {
      controller = CameraController(value[1], ResolutionPreset.high);

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              AppSnackBar.showSnackBar(
                  context, 'You have denied camera access.');
              break;
            case 'CameraAccessDeniedWithoutPrompt':
              // iOS only
              AppSnackBar.showSnackBar(context,
                  'Please go to Settings app to enable camera access.');
              break;
            case 'CameraAccessRestricted':
              // iOS only
              AppSnackBar.showSnackBar(context, 'Camera access is restricted.');
              break;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? oldController = controller;
    if (oldController != null) {
      // `controller` needs to be set to null before getting disposed,
      // to avoid a race condition when we use the controller that is being
      // disposed. This happens when camera permission dialog shows up,
      // which triggers `didChangeAppLifecycleState`, which disposes and
      // re-creates the controller.
      controller = null;
      await oldController.dispose();
    }

    if (mounted) {
      setState(() {});
    }
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
                color: AppColors.primaryColor,
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
                      color: AppColors.primaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  child: CameraPreview(controller!),
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
                onPressed: () async {
                  final image = await controller!.takePicture();

                  if (!mounted) return;

                  await navigationService.navigateToRoute(DisplayPictureScreen(
                    image: image,
                  ));
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
}
