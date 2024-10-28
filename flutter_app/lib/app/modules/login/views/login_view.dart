import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/components/login_input/login_input.dart';
import '../../../core/constants/colors/app_color.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      color: const Color(0xff30A7D1),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SizedBox(
            height: Get.height - 120,
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
              'login_title'.tr,
              style: TextStyle(
                fontSize: 32.rpx,
                color: const Color(0xff383838),
              ),
            ),
            SizedBox(height: 20.rpx),
            LoginInput(
              leftIcon: AppIcon.mine,
              hintText: 'login_account'.tr,
              controller: controller.emailEditController,
              onChanged: (text) {
                controller.onAllChanged();
              },
            ),
            SizedBox(height: 30.rpx),
            LoginInput(
              leftIcon: AppIcon.mine,
              obscureText: controller.eyeOpen.value ? false : true,
              hintText: 'login_password'.tr,
              controller: controller.passwordEditController,
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
            SizedBox(height: 30.rpx),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                'login_forgot'.tr,
                style: TextStyle(
                  color: const Color(0xff333333).withOpacity(0.4),
                  fontSize: 26.rpx,
                ),
              ),
            ),
            SizedBox(height: 60.rpx),
            TDButton(
              width: double.infinity,
              text: 'login_submit'.tr,
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
                  'login_no_account'.tr,
                  style: TextStyle(fontSize: 28.rpx),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  child: Text(
                    'login_register'.tr,
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
                      color: AppColor.primaryColor,
                      fontSize: 28.rpx,
                    ),
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
