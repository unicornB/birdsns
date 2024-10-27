import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/service/app_service.dart';

import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/utils/tool/app_util.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final TextEditingController emailEditController = TextEditingController();
  final TextEditingController passwordEditController = TextEditingController();
  final eyeOpen = false.obs;
  final submitDisabled = true.obs;
  final agree = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void toRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  void onAllChanged() {
    if (emailEditController.text.isEmpty ||
        passwordEditController.text.isEmpty ||
        !agree.value) {
      submitDisabled.value = true;
    } else {
      submitDisabled.value = false;
    }
  }

  void submit() {
    AppService.to.login(emailEditController.text, passwordEditController.text);
  }
}
