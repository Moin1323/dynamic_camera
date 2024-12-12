import 'package:flutter/cupertino.dart';

class AlignImageOverlay extends StatelessWidget {
  const AlignImageOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Image(
        image: AssetImage("lib/assets/align.png"),
        fit: BoxFit.fill,
      ),
    );
  }
}