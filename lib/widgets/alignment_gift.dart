import 'package:flutter/material.dart';

class AlignmentGifWidget extends StatelessWidget {
  final double x, y;

  const AlignmentGifWidget({super.key, required this.x, required this.y});

  String _getImageForAlignment() {
    if (y > 0.5 && y.abs() > x.abs()) {
      return 'lib/assets/gif/down side.gif';
    } else if (y < -0.5 && y.abs() > x.abs()) {
      return 'lib/assets/gif/up side.gif';
    } else if (x < -0.5 && x.abs() > y.abs()) {
      return 'lib/assets/gif/right side.gif';
    } else if (x > 0.5 && x.abs() > y.abs()) {
      return 'lib/assets/gif/left side.gif';
    } else {
      return '';
    }
  }

  String _getHelpTextForAlignment() {
    if (y > 0.5 && y.abs() > x.abs()) {
      return 'Move Upwards to Align';
    } else if (y < -0.5 && y.abs() > x.abs()) {
      return 'Move Downwards to Align';
    } else if (x < -0.5 && x.abs() > y.abs()) {
      return 'Move Leftwards to Align';
    } else if (x > 0.5 && x.abs() > y.abs()) {
      return 'Move Rightwards to Align';
    } else {
      return 'Perfectly Aligned, now fit the coin into the circle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.sizeOf(context).width;
    final appHeight = MediaQuery.sizeOf(context).height * 0.85;

    return Column(
      children: [
        Expanded(
          child: _getImageForAlignment().isEmpty
              ? captureWidget()
              : Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: appHeight * 0.5,
              width: appWidth * 0.8,
              child: Image.asset(
                _getImageForAlignment(),
                color: Colors.white,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
        ),
        Container(
          width: appWidth,
          color: Colors.black.withOpacity(0.5),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _getHelpTextForAlignment(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

Widget captureWidget() {
  return Align(
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 8, right: 20),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Image.asset(
          'lib/assets/coin.png',
          color: Colors.red,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
