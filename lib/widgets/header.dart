import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String logoImagePath;
  final VoidCallback onClose;

  const HeaderWidget({
    super.key,
    required this.logoImagePath,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.07,
            child: Image.network(logoImagePath),
          ),
        ),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close, color: Colors.white),
        ),
      ],
    );
  }
}
