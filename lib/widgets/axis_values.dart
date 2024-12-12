import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AxisValuesWidget extends StatelessWidget {
  final double x, y, z;

  const AxisValuesWidget({super.key, required this.x, required this.y, required this.z});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("X-Axis: ${x.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, color: Colors.white)),
          Text("Y-Axis: ${y.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, color: Colors.white)),
          Text("Z-Axis: ${z.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }
}