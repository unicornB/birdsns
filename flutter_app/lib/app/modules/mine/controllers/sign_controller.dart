import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';

class SignController extends GetxController {
  TextEditingController signEditController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    signEditController.text = AppService.to.loginUserInfo.value.bio ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    signEditController.dispose();
  }

  Future<void> updateNickname() async {
    // 更新昵称的逻辑
    if (signEditController.text.isEmpty) {
      AppUtil.showToast("user_sign_not_empty".tr);
      return;
    }

    bool success =
        await AppService.to.updateProfile({"bio": signEditController.text});
    if (success) {
      Get.back();
    }
  }
}
