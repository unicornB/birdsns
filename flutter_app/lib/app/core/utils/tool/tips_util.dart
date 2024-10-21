import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Tips {
  /// tosat常规提示
  static Future<void> info(String text, {ToastGravity? gravity}) async {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity ?? ToastGravity.BOTTOM, // 提示位置
      fontSize: 18, // 提示文字大小
    );
  }

  static Future<void> toast(String text) async {
    Tips.info(text, gravity: ToastGravity.CENTER);
  }

  static Future<void> showLoading({String text = ''}) async {
    if (text.isEmpty) {
      text = "common_loading".tr;
    }
    EasyLoading.show(status: text);
  }

  static Future<void> hideLoading() async {
    EasyLoading.dismiss();
  }
}
