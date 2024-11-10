import 'package:flutter/material.dart';

import '../custom_icons/app_icon.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomCloseButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          AppIcon.close,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
