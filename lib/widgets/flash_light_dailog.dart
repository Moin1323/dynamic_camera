import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlashlightDialog extends StatelessWidget {
  final CameraController cameraController;

  const FlashlightDialog({super.key, required this.cameraController});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enable Flashlight"),
      content: const Text("Keeping the flashlight on is important for the best results. Would you like to turn it on?"),
      actions: [
        TextButton(
          onPressed: () async {
            if (cameraController.value.isInitialized) {
              await cameraController.setFlashMode(FlashMode.torch);
              Navigator.pop(context);
            }
          },
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close dialog
            Navigator.pop(context); // Pop the screen
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }
}


