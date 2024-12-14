import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AxisValuesWidget extends StatelessWidget {
  final bool isAligned;
  final double x, y, z;

  const AxisValuesWidget({
    super.key,
    required this.x,
    required this.y,
    required this.z,
    required this.isAligned,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: isAligned ? const EdgeInsets.only(bottom: 30.0, left: 100) : EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("X-Axis: ${x.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 10,
                  color: isAligned ? Colors.red : Colors.white,
                )),
            Text("Y-Axis: ${y.toStringAsFixed(2)}",
                style:  TextStyle(
                  fontSize: 10,
                  color: isAligned ? Colors.red : Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
