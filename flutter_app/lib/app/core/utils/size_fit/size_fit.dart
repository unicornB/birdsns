import 'package:flutter/material.dart';

class SizeFit {
  static double physicalWidth = 0;
  static double physicalHeight = 0;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double dpr = 0;
  static double statusHeight = 0;

  static double rpx = 0;
  static double px = 0;

  static void initialize({standardSize = 750}) {
    var window = WidgetsBinding.instance.platformDispatcher.views.first;
//    1. 手机的物理分辨率
    physicalWidth = window.physicalSize.width; // 拿到物理的宽度
    physicalHeight = window.physicalSize.height;

//    2. 求出dpr
    dpr = window.devicePixelRatio;

//    3. 求出逻辑的宽高
    screenWidth = physicalWidth / dpr;
    screenHeight = physicalHeight / dpr;

//    4. 状态栏高度
    statusHeight = window.padding.top / dpr;

//    5. 计算rpx
    rpx = screenWidth / standardSize;
    px = screenWidth / standardSize * 2;
  }

  static double setRpx(double size) {
    return size * rpx;
  }

  static double setPx(double size) {
    return size * px;
  }
}
