import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../config/app_config.dart';
import '../../../routes/app_pages.dart';

class AppUtil {
  //底部安全区域高度
  static double getSafeAreaHeight() {
    return MediaQuery.of(Get.context!).padding.bottom;
  }

  static void toPriva() {
    String url = "${AppConfig.host}/index/index/article?pageid=privacy";
    Get.toNamed(Routes.WEB, arguments: {"url": url, "title": "隐私政策"});
  }

  static void toUserAgree() {
    String url = "${AppConfig.host}/index/index/article?pageid=useragreement";
    Get.toNamed(Routes.WEB, arguments: {"url": url, "title": "用户协议"});
  }

  static void showLoading(String text) {
    if (text.isEmpty) {
      TDToast.showLoadingWithoutText(context: Get.context!);
    } else {
      TDToast.showLoading(context: Get.context!, text: text);
    }
  }

  static void hideLoading() {
    TDToast.dismissLoading();
  }

  static void showToast(String text) {
    //TDToast.showText(text, context: Get.context!);
    EasyLoading.showToast(text);
  }
}
