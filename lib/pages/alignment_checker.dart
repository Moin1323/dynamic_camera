import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';
import 'dart:math';

class AlignmentChecker extends StatefulWidget {
  @override
  _AlignmentCheckerState createState() => _AlignmentCheckerState();
}

class _AlignmentCheckerState extends State<AlignmentChecker> {
  double x = 0.0, y = 0.0, z = 0.0;
  bool isAligned = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    // Listen to accelerometer events
    _subscription = accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;

        // Add margin of error to the alignment criteria
        isAligned = (x.abs() < 1.0) && (y.abs() < 1.0) && ((z - 9.8).abs() < 1.0);
      });
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Alignment Checker")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "X-Axis: ${x.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Y-Axis: ${y.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Z-Axis: ${z.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 50),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isAligned ? Colors.green : Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  isAligned ? "Aligned" : "Not Aligned",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
