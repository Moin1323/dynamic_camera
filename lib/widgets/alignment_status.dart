import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlignmentStatusWidget extends StatelessWidget {
  final bool isAligned;

  const AlignmentStatusWidget({super.key, required this.isAligned});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isAligned ? Colors.green : Colors.red,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

