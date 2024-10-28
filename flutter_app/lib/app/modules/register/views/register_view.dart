import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/components/login_input/login_input.dart';
import 'package:flutter_app/app/core/constants/fontsize_constants.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import '../controllers/register_controller.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/constants/colors/app_color.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      color: const Color(0xff30A7D1),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 100,
            child: Stack(
              fit: StackFit.loose,
              children: [_logoView(), Obx(() => _loginForm())],
            ),
          ),
        ),
      ),
    );
  }

  Widget _logoView() {
    return Container(
      width: Get.width,
      height: Get.width,
      alignment: Alignment.center,
      color: const Color(0xff30A7D1),
      child: Image.asset(
        'assets/images/login_bg.png',
        width: Get.width,
        height: Get.width,
        fit: BoxFit.cover,
      ),
    );
  }

  Positioned _loginForm() {
    return Positioned(
      bottom: 0,
      top: Get.width * 0.7,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 30.rpx),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20.rpx),
            Text(
              'register_title'.tr,
              style: TextStyle(
                fontSize: 32.rpx,
                color: const Color(0xff383838),
              ),
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.mine,
              hintText: 'register_username'.tr,
              controller: controller.usernameEditController,
              onChanged: (text) {
                controller.onAllChanged();
              },
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.email,
              hintText: 'login_email'.tr,
              controller: controller.emailEditController,
              onChanged: (text) {
                controller.onEmailChanged(text);
                controller.onAllChanged();
              },
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.verification,
              hintText: 'register_code'.tr,
              controller: controller.codeEditController,
              onChanged: (text) {
                controller.onAllChanged();
              },
              rightBtn: GestureDetector(
                onTap: () {},
                child: TDButton(
                  text: controller.sendBtnText.value,
                  size: TDButtonSize.small,
                  type: TDButtonType.outline,
                  shape: TDButtonShape.rectangle,
                  theme: TDButtonTheme.primary,
                  disabled: controller.sendCodeDisabled.value,
                  textStyle: TextStyle(
                    fontSize: 20.rpx,
                    fontWeight: FontWeight.w400,
                  ),
                  disableTextStyle: TextStyle(
                    fontSize: 28.rpx,
                    fontWeight: FontWeight.w400,
                  ),
                  onTap: () {
                    controller.sendCode();
                  },
                ),
              ),
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.password,
              hintText: 'login_password'.tr,
              controller: controller.passwordEditController,
              obscureText: controller.eyeOpen.value ? false : true,
              onChanged: (text) {
                controller.onAllChanged();
              },
              rightBtn: GestureDetector(
                onTap: () {
                  controller.eyeOpen.value = !controller.eyeOpen.value;
                },
                child: Icon(
                  controller.eyeOpen.value ? AppIcon.eyeOpen : AppIcon.eyeClose,
                  color: const Color(0xff666666),
                ),
              ),
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.password,
              hintText: 'login_password'.tr,
              controller: controller.passwordConfirmEditController,
              obscureText: controller.eyeOpen.value ? false : true,
              onChanged: (text) {
                controller.onAllChanged();
              },
              rightBtn: GestureDetector(
                onTap: () {
                  controller.eyeOpen.value = !controller.eyeOpen.value;
                },
                child: Icon(
                  controller.eyeOpen.value ? AppIcon.eyeOpen : AppIcon.eyeClose,
                  color: const Color(0xff666666),
                ),
              ),
            ),
            SizedBox(height: 50.rpx),
            TDButton(
              width: double.infinity,
              text: 'register_submit'.tr,
              size: TDButtonSize.medium,
              type: TDButtonType.fill,
              shape: TDButtonShape.circle,
              theme: TDButtonTheme.primary,
              textStyle: TextStyle(fontSize: 28.rpx),
              disabled: controller.submitDisabled.value,
              onTap: controller.submit,
            ),
            SizedBox(height: 20.rpx),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'register_has_account'.tr,
                  style: TextStyle(fontSize: 28.rpx),
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    'register_back'.tr,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 28.rpx,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.rpx),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.scale(
                  scale: 0.8,
                  child: TDCheckbox(
                    style: TDCheckboxStyle.square,
                    titleMaxLine: 1,
                    checked: controller.agree.value,
                    onCheckBoxChanged: (selected) {
                      controller.agree.value = selected;
                      controller.onAllChanged();
                    },
                  ),
                ),
                Text(
                  'login_agree_text1'.tr,
                  style: TextStyle(fontSize: 28.rpx),
                ),
                GestureDetector(
                  onTap: () {
                    AppUtil.toUserAgree();
                  },
                  child: Text(
                    'login_agree_text2'.tr,
                    style: TextStyle(
                        color: AppColor.primaryColor, fontSize: 28.rpx),
                  ),
                ),
                Text(
                  'login_agree_text3'.tr,
                  style: TextStyle(fontSize: 28.rpx),
                ),
                GestureDetector(
                  onTap: () {
                    AppUtil.toPriva();
                  },
                  child: Text(
                    'login_agree_text4'.tr,
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 28.rpx,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
