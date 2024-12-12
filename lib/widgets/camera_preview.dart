import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatelessWidget {
  final Future<void> cameraValue;
  final CameraController cameraController;

  const CameraPreviewWidget({
    super.key,
    required this.cameraValue,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cameraValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
              height: MediaQuery.sizeOf(context).height,
              width: MediaQuery.sizeOf(context).width,
              child: CameraPreview(cameraController));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
