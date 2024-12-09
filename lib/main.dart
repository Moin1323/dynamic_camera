import 'package:camera/camera.dart';
import 'package:dynamic_camera/pages/scan_start_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  List<CameraDescription> _cameras = [];

  Future<void> _initializeCameras() async {
    _cameras = await availableCameras();
  }

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScanStartScreen(cameras: _cameras),
    );
  }
}
