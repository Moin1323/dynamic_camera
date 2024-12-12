import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CloseButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CloseButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: onPressed,
        icon: const Icon(Icons.close, color: Colors.white),
      ),
    );
  }
}
