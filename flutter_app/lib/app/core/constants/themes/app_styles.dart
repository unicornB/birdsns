import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class AppStyles {
  AppStyles._();
  static TDCellStyle tdCellStyle = TDCellStyle();
  static TextStyle postContentStyle = TextStyle(
    fontSize: 28.rpx,
    color: AppColor.title,
  );
}
