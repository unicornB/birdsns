import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/login_api.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:flutter_app/app/core/utils/tool/validate_util.dart';
import 'package:get/get.dart';
import 'package:sprintf/sprintf.dart';

class RegisterController extends GetxController {
  final TextEditingController usernameEditController = TextEditingController();
  final TextEditingController emailEditController = TextEditingController();
  final TextEditingController passwordEditController = TextEditingController();
  final TextEditingController passwordConfirmEditController =
      TextEditingController();
  final TextEditingController codeEditController = TextEditingController();
  final eyeOpen = false.obs;
  final sendCodeDisabled = true.obs;
  final submitDisabled = true.obs;
  final agree = false.obs;
  final count = 120.obs;
  final sendBtnText = "register_send_code".tr.obs;
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

  void increment() => count.value++;

  Future<void> sendCode() async {
    if (emailEditController.text.isEmpty) {
      AppUtil.showToast("请输入邮箱");
      return;
    }
    if (!ValidateUtil.isEmail(emailEditController.text)) {
      AppUtil.showToast("请输入正确的邮箱");
      return;
    }
    AppUtil.showLoading("发送中...");
    var res = await LoginApi.sendRegisterCode(emailEditController.text);
    AppUtil.hideLoading();
    AppUtil.showToast(res['msg']);
    if (res != null && res['code'] == 1) {
      Timer.periodic(const Duration(milliseconds: 1000), (timer) {
        count.value--;
        sendBtnText.value =
            sprintf("register_send_code_time".tr, [count.value]);
        if (count.value == 0) {
          timer.cancel();
          sendBtnText.value = "register_send_code".tr;
          count.value = 120;
        }
      });
    }
  }

  void onEmailChanged(email) {
    if (ValidateUtil.isEmail(email)) {
      sendCodeDisabled.value = false;
    } else {
      sendCodeDisabled.value = true;
    }
  }

  void onAllChanged() {
    if (usernameEditController.text.isEmpty ||
        emailEditController.text.isEmpty ||
        codeEditController.text.isEmpty ||
        passwordEditController.text.isEmpty ||
        passwordEditController.text != passwordConfirmEditController.text ||
        !ValidateUtil.isEmail(emailEditController.text) ||
        !agree.value) {
      submitDisabled.value = true;
    } else {
      submitDisabled.value = false;
    }
  }

  void submit() {
    var data = {
      "username": usernameEditController.text,
      "email": emailEditController.text,
      "code": codeEditController.text,
      "password": passwordEditController.text,
    };
    AppUtil.showLoading("register_submiting".tr);
    LoginApi.register(data).then((res) {
      AppUtil.hideLoading();
      AppUtil.showToast(res['msg']);
      if (res['code'] == 1) {
        Get.back();
      }
    }).catchError((err) {
      AppUtil.hideLoading();
    });
  }
}
