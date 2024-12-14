import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaptureButtonWidget extends StatelessWidget {
  final bool isAligned;
  final VoidCallback onPressed;

  const CaptureButtonWidget({super.key, required this.isAligned, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: isAligned ? Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: IconButton(
          iconSize: 70,
          icon: const Icon(
            Icons.camera,
            color: Colors.red,
          ),
          onPressed: onPressed,
        ),
      ) : const SizedBox(),
    );
  }
}