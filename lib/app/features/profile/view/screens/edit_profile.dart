import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/app/features/profile/view/widgets/account_info_card.dart';
import 'package:floatr/app/widgets/app_text.dart';
import 'package:floatr/app/widgets/custom_appbar.dart';
import 'package:floatr/app/widgets/general_button.dart';
import 'package:floatr/app/widgets/text_field.dart';
import 'package:floatr/core/utils/spacing.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_style.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key, required this.editProfileView})
      : super(key: key);

  final EditProfile editProfileView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        useInAppArrow: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SizedBox(
          width: context.widthPx,
          child: _view(editProfileView),
        ),
      ),
    );
  }
}

class EditResidentialAddressView extends StatelessWidget {
  const EditResidentialAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpace(size: 60),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          height: 453,
          width: context.widthPx,
          infoTitle: 'Residential Address',
          child: Column(
            children: const [
              // country

              // state

              // city

              // street add
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        GeneralButton(
          onPressed: () {},
          height: 48,
          borderRadius: 12,
          child: const AppText(
            text: 'UPDATE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class EditEmploymentView extends StatelessWidget {
  const EditEmploymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpace(size: 60),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          width: context.widthPx,
          height: 453,
          infoTitle: 'Employer’s Information',
          child: Column(
            children: const [
              // company name

              // employers address

              // employment type

              // position

              // monthly income
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        GeneralButton(
          onPressed: () {},
          height: 48,
          borderRadius: 12,
          child: const AppText(
            text: 'UPDATE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class EditNextOfKinView extends StatelessWidget {
  const EditNextOfKinView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpace(size: 60),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          height: 453,
          width: context.widthPx,
          infoTitle: 'Next of Kin (Personal Details)',
          child: Column(
            children: const [
              // relationship

              // name

              // employment type

              // phone number

              // email address
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        AccountInfoCard(
          height: 453,
          width: context.widthPx,
          infoTitle: 'Next of Kin Address',
          child: Column(
            children: const [
              // country

              // state

              // city

              // street address
            ],
          ),
        ),

        const VerticalSpace(size: 30),

        GeneralButton(
          onPressed: () {},
          height: 48,
          borderRadius: 12,
          child: const AppText(
            text: 'UPDATE',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class EditProfileView extends StatelessWidget {
  const EditProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const VerticalSpace(size: 60),

        // user image
        const CircleAvatar(radius: 44),

        const VerticalSpace(size: 30),

        // primary info
        AccountInfoCard(
          height: 290,
          width: context.widthPx,
          infoTitle: 'Primary Information',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              // fullname
              PrimaryInfoItem(
                text: 'Full Name',
                subText: 'Adanna Erica',
              ),

              // phone number
              PrimaryInfoItem(
                text: 'Phone Number',
                subText: '+234 813 456 0322',
              ),

              // bvn
              PrimaryInfoItem(
                text: 'BVN',
                subText: '22300912356',
              ),

              // dob
              PrimaryInfoItem(
                text: 'Date of Birth',
                subText: '15-09-3030',
              ),
            ],
          ),
        ),

        const VerticalSpace(size: 15),

        // others
        AccountInfoCard(
          infoTitle: 'Others',
          height: 320,
          width: context.widthPx,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VerticalSpace(size: 10),

              // marital status
              Text(
                'Marital Status',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Single')),

              const VerticalSpace(size: 10),

              // Gender
              Text(
                'Gender',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(controller: TextEditingController(text: 'Female')),

              const VerticalSpace(size: 10),

              Text(
                'State of Origin',
                style: TextStyles.smallTextDark14Px,
              ).paddingOnly(bottom: 8),
              AppTextField(
                  controller: TextEditingController(text: 'Imo state')),
            ],
          ),
        ),

        const VerticalSpace(size: 40),

        GeneralButton(
          onPressed: () {},
          height: 48,
          child: const AppText(
            text: 'SAVE CHANGES',
            color: Colors.white,
            fontWeight: FontWeight.w700,
            size: 16,
            letterSpacing: 1.5,
          ),
        ),

        const VerticalSpace(size: 40),
      ],
    );
  }
}

class PrimaryInfoItem extends StatelessWidget {
  const PrimaryInfoItem({
    Key? key,
    required this.subText,
    required this.text,
  }) : super(key: key);

  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyles.smallTextDark14Px,
        ).paddingOnly(bottom: 5),
        Text(subText, style: TextStyles.smallTextGrey14Px),
      ],
    ).paddingOnly(top: 12);
  }
}

Widget _view(EditProfile editProfile) {
  switch (editProfile) {
    case EditProfile.personalDetails:
      return const EditProfileView();
    case EditProfile.nextOfKin:
      return const EditNextOfKinView();
    case EditProfile.residentialAddress:
      return const EditResidentialAddressView();
    case EditProfile.employmentDetails:
      return const EditEmploymentView();
    default:
      return const EditProfileView();
  }
}

enum EditProfile {
  personalDetails,
  residentialAddress,
  employmentDetails,
  nextOfKin,
}

class EditProfileArguments {
  final EditProfile editProfileView;

  EditProfileArguments({required this.editProfileView});
}
