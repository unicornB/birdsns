import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/login_input/login_input.dart';

import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../controllers/sign_controller.dart';

class SignView extends GetView<SignController> {
  const SignView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          title: Text("user_edit_sign".tr),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.white,
              padding:
                  EdgeInsets.symmetric(horizontal: 20.px, vertical: 30.rpx),
              child: Column(
                children: [
                  LoginInput(
                    controller: controller.signEditController,
                    needClear: true,
                    hintText: "user_enter_sign".tr,
                    rightBtn: null,
                  ),
                  SizedBox(
                    height: 20.px,
                  ),
                  TDButton(
                    width: double.infinity,
                    text: 'user_save'.tr,
                    size: TDButtonSize.medium,
                    type: TDButtonType.fill,
                    shape: TDButtonShape.circle,
                    theme: TDButtonTheme.primary,
                    textStyle: TextStyle(fontSize: 28.rpx),
                    onTap: controller.updateNickname,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
