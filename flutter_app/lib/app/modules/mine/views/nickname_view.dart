import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/login_input/login_input.dart';

import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../controllers/nickname_controller.dart';

class NicknameView extends GetView<NicknameController> {
  const NicknameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          title: Text("user_edit_nickname".tr),
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
                    controller: controller.nicknameController,
                    needClear: true,
                    hintText: "user_enter_nickname".tr,
                    rightBtn: null,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.px),
                    width: double.infinity,
                    child: Text(
                      "user_nickname_limit".tr,
                      style: TextStyle(fontSize: 28.rpx, color: Colors.grey),
                    ),
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
