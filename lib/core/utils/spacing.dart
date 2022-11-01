import 'package:flutter/material.dart'
    show BuildContext, Key, MediaQuery, SizedBox, StatelessWidget, Widget;

class VerticalSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  const VerticalSpace({
    Key? key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenHeight;
    return SizedBox(height: size);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double size;
  final SizeUnit unit;

  const HorizontalSpace({
    Key? key,
    this.size = 8.0,
    this.unit = SizeUnit.pixel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final size =
        unit == SizeUnit.pixel ? this.size : this.size / 100 * screenWidth;
    return SizedBox(width: size);
  }
}

enum SizeUnit { pixel, percent }
