import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:async';

import '../widgets/align_image_overlay.dart';
import '../widgets/alignment_status.dart';
import '../widgets/axis_values.dart';
import '../widgets/camera_preview.dart';
import '../widgets/capture_button.dart';
import '../widgets/cature_image_dailog.dart';
import '../widgets/close_button.dart';
import '../widgets/flash_light_dailog.dart';

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
            (_x.abs() < 0.7) && (_y.abs() < 0.7) && ((_z - 9.8).abs() < 0.7);
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

    String getImageForAlignment() {
      debugPrint('x: $_x, y: $_y, z: $_z');

      if (_y > 0.7 && _y.abs() > _x.abs()) {
        debugPrint('Top Tilted');
        return 'lib/assets/gif/down side.gif';
      } else if (_y < -0.7 && _y.abs() > _x.abs()) {
        debugPrint('Bottom Tilted');
        return 'lib/assets/gif/up side.gif';
      } else if (_x < -0.7 && _x.abs() > _y.abs()) {
        debugPrint('Left Tilted');
        return 'lib/assets/gif/right side.gif';
      } else if (_x > 0.7 && _x.abs() > _y.abs()) {
        debugPrint('Right Tilted');
        return 'lib/assets/gif/left side.gif';
      } else {
        debugPrint('Default Alignment');
        return 'lib/assets/coin.png';
      }
    }

    final alignmentImage = getImageForAlignment();

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
                  cameraController: _cameraController),
              const Positioned.fill(child: AlignImageOverlay()),
              AxisValuesWidget(x: _x, y: _y, z: _z),
              AlignmentStatusWidget(isAligned: _isAligned),
              CaptureButtonWidget(
                  isAligned: _isAligned, onPressed: _takePicture),
              CloseButtonWidget(onPressed: () => Navigator.pop(context)),
              // Image overlay based on alignment
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: appHeight * 0.4,
                  width: appWidth * 0.4,
                  child: Image.asset(
                    alignmentImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
