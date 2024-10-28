import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';

import '../../constants/Images.dart';

class SvgIcon {
  static Widget settings = Images.settings.toSvg(
    width: 50.rpx,
    height: 50.rpx,
    color: Colors.white,
  );
}
