import 'package:flutter/material.dart';

class AlignmentGifWidget extends StatelessWidget {
  final double x, y;

  const AlignmentGifWidget({super.key, required this.x, required this.y});

  String _getImageForAlignment() {
    if (y > 0.7 && y.abs() > x.abs()) {
      return 'lib/assets/gif/down side.gif';
    } else if (y < -0.7 && y.abs() > x.abs()) {
      return 'lib/assets/gif/up side.gif';
    } else if (x < -0.7 && x.abs() > y.abs()) {
      return 'lib/assets/gif/right side.gif';
    } else if (x > 0.7 && x.abs() > y.abs()) {
      return 'lib/assets/gif/left side.gif';
    } else {
      return 'lib/assets/coin.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.sizeOf(context).width;
    final appHeight = MediaQuery.sizeOf(context).height * 0.85;

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: appHeight * 0.4,
        width: appWidth * 0.4,
        child: Image.asset(
          _getImageForAlignment(),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
