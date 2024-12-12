import 'package:camera/camera.dart';
import 'package:dynamic_camera/pages/process_image.dart';
import 'package:flutter/material.dart';

class ScanStartScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const ScanStartScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isLandscape = screenWidth > screenHeight;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: SizedBox(
              width: isLandscape ? screenWidth / 2 : screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, size: 40),
                  SizedBox(height: screenHeight / 35),
                  const Text(
                    "Let's Scan some hands!",
                    style: TextStyle(fontSize: 30),
                  ),
                  SizedBox(height: screenHeight / 22),
                  IconButton(
                    icon: const Icon(Icons.search_rounded, size: 30),
                    onPressed: () {
                      if (cameras.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("No Cameras Available"),
                            content: const Text(
                                "No cameras found on your device. Please check camera permissions."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"),
                              ),
                            ],
                          ),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProcessImage(cameras: cameras),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
