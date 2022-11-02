import 'package:floatr/app/extensions/sized_context.dart';
import 'package:floatr/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_text.dart';

class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      height: context.heightPx * 0.32,
      width: context.widthPx,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () {},
                keyValue: '1',
              ),

              // 2
              KeyboardKey(
                onTap: () {},
                keyValue: '2',
              ),

              // 3
              KeyboardKey(
                onTap: () {},
                keyValue: '3',
              ),
            ],
          ),

          // 4 5 6
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () {},
                keyValue: '4',
              ),

              // 2
              KeyboardKey(
                onTap: () {},
                keyValue: '5',
              ),

              // 3
              KeyboardKey(
                onTap: () {},
                keyValue: '6',
              ),
            ],
          ),

          // 7 8 9
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () {},
                keyValue: '7',
              ),

              // 2
              KeyboardKey(
                onTap: () {},
                keyValue: '8',
              ),

              // 3
              KeyboardKey(
                onTap: () {},
                keyValue: '9',
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 1
              KeyboardKey(
                onTap: () {},
                keyValue: '#',
              ),

              // 2
              KeyboardKey(
                onTap: () {},
                keyValue: '0',
              ),

              // 3
              KeyboardKey(
                onTap: () {},
                keyValue: '*',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class KeyboardKey extends StatelessWidget {
  final Function onTap;
  final String keyValue;

  // ignore: use_key_in_widget_constructors
  const KeyboardKey({required this.onTap, required this.keyValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: AppColors.primaryColor.withOpacity(0.2),
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      onTap: () => onTap,
      child: SizedBox(
        width: context.widthPx * 0.1,
        child: Center(
          child: AppText(
            text: keyValue,
            fontWeight: FontWeight.w500,
            size: context.widthPx * 0.075,
          ),
        ),
      ),
    );
  }
}

class KeyboardProvider with ChangeNotifier {
  
}
