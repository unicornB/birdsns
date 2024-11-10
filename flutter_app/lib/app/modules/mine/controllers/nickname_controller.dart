import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';

class NicknameController extends GetxController {
  TextEditingController nicknameController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    nicknameController.text = AppService.to.loginUserInfo.value.nickname!;
  }

  @override
  void dispose() {
    super.dispose();
    nicknameController.dispose();
  }

  Future<void> updateNickname() async {
    // 更新昵称的逻辑
    if (nicknameController.text.isEmpty) {
      AppUtil.showToast("user_nickname_not_empty".tr);
      return;
    }

    bool success = await AppService.to.updateNickName(nicknameController.text);
    if (success) {
      Get.back();
    }
  }
}
