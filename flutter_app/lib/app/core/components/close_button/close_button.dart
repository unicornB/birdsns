import 'package:flutter/material.dart';

import '../custom_icons/app_icon.dart';

class CustomCloseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? color;
  const CustomCloseButton(
      {super.key, this.onPressed, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: color!.withOpacity(0.8),
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
