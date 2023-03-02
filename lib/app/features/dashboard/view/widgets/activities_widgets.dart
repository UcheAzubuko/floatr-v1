import 'package:floatr/app/extensions/padding.dart';
import 'package:floatr/app/features/dashboard/data/model/response/activities_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_style.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../widgets/app_text.dart';

class ActivitiesList extends StatelessWidget {
  const ActivitiesList({
    Key? key,
    required this.activities,
  }) : super(key: key);

  final List<Activity> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: const EdgeInsets.all(0),
        itemBuilder: (_, __) => ActivityItem(activity: activities[__],),
        separatorBuilder: (_, __) => const SizedBox(
              height: 10,
            ),
        itemCount: activities.length);
  }
}

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    Key? key,
    required this.activity,
  }) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd MMM yyyy ');


    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // icon
              Container(
                height: 52,
                width: 52,
                // color: AppColors.lightGrey,
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(40)),
                child: SvgPicture.asset(
                  'assets/icons/outline/transfer_wallet.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
              ).paddingOnly(right: 8),

              // activity title
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.message,
                    style: TextStyles.smallTextDark,
                  ),
                  Text(
                    dateFormat.format(activity.createdAt),
                    style: TextStyles.smallTextGrey,
                  ),
                ],
              ),

              // amount // activity status
            ],
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   '₦10,000',
                //   style: TextStyles.smallTextDark,
                // ).paddingOnly(bottom: 10),
                Container(
                  height: 21,
                  width: 65,
                  decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: AppText(
                      text: 'Success',
                      color: Colors.green,
                      size: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NoActivityView extends StatelessWidget {
  const NoActivityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 110,
          width: 155,
          child: Image.asset('assets/images/analytics-image.png'),
        ),
        Text(
          'No Activity Yet',
          style: TextStyles.normalTextDarkF800,
        ),
        const VerticalSpace(
          size: 10,
        ),
        const Text(
          '''Start taking loans and all your history will 
          appear here''',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
