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
      child: IconButton(
        iconSize: 70,
        icon: Icon(
          Icons.camera,
          color: isAligned ? Colors.white : Colors.grey,
        ),
        onPressed: isAligned ? onPressed : null,
      ),
    );
  }
}