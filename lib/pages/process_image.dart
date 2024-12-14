import 'dart:io';
import 'package:camera/camera.dart';
import 'package:dynamic_camera/widgets/alignment_gift.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

import '../widgets/align_image_overlay.dart';
import '../widgets/alignment_status.dart';
import '../widgets/axis_values.dart';
import '../widgets/camera_preview.dart';
import '../widgets/capture_button.dart';
import '../widgets/cature_image_dailog.dart';
import '../widgets/flash_light_dailog.dart';
import '../widgets/header.dart';

class ProcessImage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const ProcessImage({super.key, required this.cameras});

  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  late CameraController _cameraController;
  late Future<void> _cameraValue;
  double _x = 0.0, _y = 0.0, _z = 0.0;
  bool _isAligned = false;
  StreamSubscription? _sensorSubscription;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      _initializeCamera(0);
    }
    _subscribeToAccelerometer();
  }

  void _subscribeToAccelerometer() {
    _sensorSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _x = event.x;
        _y = event.y;
        _z = event.z;
        _isAligned =
            (_x.abs() < 0.3) && (_y.abs() < 0.3) && ((_z - 9.8).abs() < 0.3);
      });
    });
  }

  void _initializeCamera(int cameraIndex) {
    if (widget.cameras.isEmpty) return;
    _cameraController = CameraController(
      widget.cameras[cameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );
    _cameraValue = _cameraController.initialize().then((_) {
      _cameraController.setFlashMode(FlashMode.off);
      if (mounted) _showFlashlightDialog();
    }).catchError((e) {
      debugPrint("Error initializing camera: $e");
    });
  }

  @override
  void dispose() {
    _sensorSubscription?.cancel();
    _cameraController.dispose();
    super.dispose();
  }

  void _showFlashlightDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return FlashlightDialog(cameraController: _cameraController);
      },
    );
  }

  void _takePicture() async {
    if (_cameraController.value.isTakingPicture ||
        !_cameraController.value.isInitialized) return;
    XFile image = await _cameraController.takePicture();
    if (mounted) {
      showDialog(
        context: context,
        builder: (context) {
          return CapturedImageDialog(imagePath: image.path);
        },
      );
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final appWidth = MediaQuery.sizeOf(context).width;
    final appHeight = MediaQuery.sizeOf(context).height * 0.85;

    return Center(
      child: SizedBox(
        width: appWidth,
        height: appHeight,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              CameraPreviewWidget(
                cameraValue: _cameraValue,
                cameraController: _cameraController,
              ),
              HeaderWidget(
                logoImagePath:
                "https://fldai.s3.amazonaws.com/static/website/images/header_logo.png",
                onClose: () => Navigator.pop(context),
              ),
              AlignmentGifWidget(x: _x, y: _y),
              AxisValuesWidget(
                x: _x,
                y: _y,
                z: _z,
                isAligned: _isAligned,
              ),
              CaptureButtonWidget(
                isAligned: _isAligned,
                onPressed: _takePicture,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
