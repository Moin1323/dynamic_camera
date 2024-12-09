import 'dart:io';
import 'package:camera/camera.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';

class ProcessImage extends StatefulWidget {
  final List<CameraDescription> cameras;
  const ProcessImage({super.key, required this.cameras});

  @override
  State<ProcessImage> createState() => _ProcessImageState();
}

class _ProcessImageState extends State<ProcessImage> {
  late CameraController cameraController;
  late Future<void> cameraValue;
  bool isFlashOn = false;

  Future<File> saveImage(XFile image) async {
    final downloadPath = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    final fileName = "${DateTime.now().millisecondsSinceEpoch}.png";
    final file = File('$downloadPath/$fileName');

    try {
      await file.writeAsBytes(await image.readAsBytes());
    } catch (_) {}
    return file;
  }

  void takePicture() async {
    XFile? image;
    if (cameraController.value.isTakingPicture ||
        !cameraController.value.isInitialized) {
      return;
    }
    image = await cameraController.takePicture();
    if (cameraController.value.flashMode == FlashMode.torch) {
      setState(() {
        cameraController.setFlashMode(FlashMode.off);
      });
    }

    final file = await saveImage(image);

    setState(() {});
  }

  void startCamera(int camera) {
    cameraController = CameraController(
      widget.cameras[camera],
      ResolutionPreset.high,
      enableAudio: false,
    );
    cameraValue = cameraController.initialize();
  }

  @override
  void initState() {
    startCamera(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return SizedBox(
                    width: size.width,
                    height: size.height,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: 100,
                        child: CameraPreview(cameraController),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Transform.scale(
                    scale: 1,
                    child: Padding(
                      padding: EdgeInsets.only(top: size.height / 19.6),
                      child: Image.asset("lib/assets/hand.png"),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: size.height / 15,
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.height / 65),
                      child: const Text(
                        "Use flashlight for better results",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        // First, handle the flash mode logic
                        setState(() {
                          isFlashOn = !isFlashOn;
                        });

                        // Then, apply the changes based on the new value of `isFlashOn`
                        if (isFlashOn) {
                          await cameraController.setFlashMode(FlashMode.torch);
                        } else {
                          await cameraController.setFlashMode(FlashMode.off);
                        }
                      },
                      icon: Icon(
                        isFlashOn
                            ? Icons.flashlight_on_outlined
                            : Icons.flashlight_off_outlined,
                        color: isFlashOn
                            ? Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(1)
                            : Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(0.4),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: size.height / 7,
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
