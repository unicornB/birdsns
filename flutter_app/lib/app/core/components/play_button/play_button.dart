import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.rpx,
      height: 80.rpx,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(900),
        borderRadius: BorderRadius.circular(50.rpx),
      ),
      child: Icon(
        AppIcon.playIcon,
        color: Colors.white,
        size: 50.rpx,
      ),
    );
  }
}
