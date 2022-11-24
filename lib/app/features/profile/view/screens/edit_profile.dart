import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/profile/view/widgets/account_info_card.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/custom_appbar.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: context.widthPx,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const VerticalSpace(size: 60),

              // user image
              const CircleAvatar(radius: 44),

              const VerticalSpace(size: 30),

              // primary info
              AccountInfoCard(
                height: 309,
                infoTitle: 'Primary Information',
                child: Column(
                  children: const [
                    // fullname

                    // phone number

                    // bvn

                    // dob
                  ],
                ),
              ),

              const VerticalSpace(size: 15),

              // others
              AccountInfoCard(
                infoTitle: 'Others',
                height: 309,
                child: Column(
                  children: const [],
                ),
              ),

              const VerticalSpace(size: 40),

              GeneralButton(
                onPressed: () {},
                height: 48,
                child: const AppText(text: 'SAVE CHANGES', color: Colors.white, fontWeight: FontWeight.w700, size: 16, letterSpacing: 1.5,),
              ).paddingSymmetric(horizontal: 16),


               const VerticalSpace(size: 40),
            ],
          ),
        ),
      ),
    );
  }
}
