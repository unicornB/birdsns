import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/color_palettes.dart';

/// 通用AppBar
AppBar commonAppBar(
    {Color statusBarColor = Colors.transparent,
    Color? backgroundColor,
    bool iconDark = true,
    PreferredSizeWidget? bottom}) {
  var isDarkStyle = ColorPalettes.instance.isDark();
  return AppBar(
    elevation: 0,
    toolbarHeight: 0,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: isDarkStyle ? Colors.transparent : Colors.transparent,
      statusBarIconBrightness: (iconDark == true && !isDarkStyle)
          ? Brightness.dark
          : Brightness.light,
    ),
    backgroundColor: backgroundColor ?? ColorPalettes.instance.background,
    bottom: bottom,
  );
}

/// 通用标题栏
PreferredSizeWidget? commonTitleBar({
  IconData? leftIcon = Icons.arrow_back,
  String title = "",
  IconData? rightIcon,
  String? rightText,
  Widget? rightWidget,
  GestureTapCallback? leftClick,
  GestureTapCallback? rightClick,
  Color? contentColor,
  Color? backgroundColor,
}) {
  Widget? right;
  if (rightText != null || rightIcon != null) {
    right = Container(
      width: 160.w,
      alignment: Alignment.centerRight,
      child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: rightClick,
          child: (rightIcon != null)
              ? Icon(
                  rightIcon,
                  size: 30,
                )
              : Text(rightText!,
                  style: TextStyle(
                      color: contentColor ?? ColorPalettes.instance.firstText,
                      fontSize: 32.w))),
    );
  } else {
    right = (rightWidget != null)
        ? GestureDetector(
            onTap: rightClick,
            child: Container(
                width: 160.w,
                alignment: Alignment.centerRight,
                child: rightWidget),
          )
        : Container(width: 160.w);
  }
  return PreferredSize(
      preferredSize: Size(double.infinity, 88.w),
      child: Container(
        height: 88.w,
        color: backgroundColor ?? Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32.w),
            Container(
              alignment: Alignment.centerLeft,
              width: 160.w,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: leftClick ?? Get.back,
                child: Icon(
                  leftIcon,
                  size: 30,
                  color: contentColor ?? ColorPalettes.instance.firstIcon,
                ),
              ),
            ),
            Expanded(
                child: Center(
                    child: Text(title,
                        style: TextStyle(
                            color: contentColor ??
                                ColorPalettes.instance.firstText,
                            fontSize: 36.w,
                            fontWeight: FontWeight.w500)))),
            right,
            SizedBox(width: 32.w),
          ],
        ),
      ));
}

void updateStatusBarColor(Color color, bool iconDark) {
  var isDarkStyle = ColorPalettes.instance.isDark();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: (iconDark == true && !isDarkStyle)
          ? Brightness.dark
          : Brightness.light));
}
