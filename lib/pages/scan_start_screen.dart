import 'package:camera/camera.dart';
import 'package:dynamic_camera/pages/process_image.dart';
import 'package:flutter/material.dart';

class ScanStartScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ScanStartScreen({super.key, required this.cameras});

  @override
  State<ScanStartScreen> createState() => _ScanStartScreenState();
}

class _ScanStartScreenState extends State<ScanStartScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    bool isLandscape = screenWidth > screenHeight;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: SizedBox(
                width: isLandscape ? screenWidth / 2 : screenWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      size: 40,
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 35),
                    const Text(
                      "Lets Scan some hands!",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height / 22),
                    IconButton(
                      icon: const Icon(
                        Icons.search_rounded,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProcessImage(cameras: widget.cameras),
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
      ),
    );
  }
}
