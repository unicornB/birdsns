import 'dart:convert';
import 'dart:developer';

import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';

import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:flutter_app/app/core/utils/tool/date_util.dart';
import 'package:flutter_app/app/modules/mine/controllers/userinfo_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/service/app_service.dart';
import '../../../routes/app_pages.dart';

class UserinfoView extends GetView<UserinfoController> {
  const UserinfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              children: [
                Obx(() => _avatarView()),
                SizedBox(
                  height: 20.rpx,
                ),
                _cardView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _avatarView() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(bottom: 60.rpx, top: 60.rpx),
      child: Stack(
        children: [
          Align(
            child: TDAvatar(
              size: TDAvatarSize.large,
              type: TDAvatarType.normal,
              avatarSize: 160.rpx,
              avatarUrl: AppService.to.loginUserInfo.value.avatar ?? "",
              onTap: () {
                AppUtil.showActionSheet(
                  List<String>.from(["common_camera".tr, "common_album".tr]),
                  onSelected: (index) {
                    log("$index");
                    if (index == 0) {
                      AppUtil.takePhoto((entity) {
                        AppService.to.updateAvatar(entity);
                      });
                    } else {
                      AppUtil.selectPhotos(
                        (files) {
                          AppService.to.updateAvatar(files[0]);
                        },
                      );
                    }
                  },
                );
              },
            ),
          ),
          Positioned(
            left: Get.width / 2 + 20.rpx,
            top: 80.rpx,
            child: IconButton(
              onPressed: () {
                AppUtil.showActionSheet(
                  List<String>.from(["common_camera".tr, "common_album".tr]),
                  onSelected: (index) {
                    log("$index");
                    if (index == 0) {
                      AppUtil.permissionDialog(
                        perName: "相机权限",
                        use: "permission_camera_use".tr,
                        icon: AppIcon.camera,
                      );
                    }
                  },
                );
              },
              icon: Container(
                width: 60.rpx,
                height: 60.rpx,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(70.rpx),
                  border: Border.all(color: Colors.white, width: 3.rpx),
                ),
                child: Icon(
                  AppIcon.camera,
                  size: 30.rpx,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cardView() {
    return TDCellGroup(
      cells: [
        TDCell(
          arrow: false,
          title: 'user_email'.tr,
          note: AppService.to.loginUserInfo.value.email ?? "",
        ),
        TDCell(
          arrow: true,
          title: 'user_nickname'.tr,
          note: AppService.to.loginUserInfo.value.nickname ??
              "user_set_nickname".tr,
          onClick: (cell) => Get.toNamed(Routes.NICKNAME),
        ),
        TDCell(
          arrow: true,
          title: 'user_sign'.tr,
          note: AppService.to.loginUserInfo.value.bio ?? "user_set_sign".tr,
          onClick: (cell) => Get.toNamed(Routes.USERSIGN),
        ),
        TDCell(
          arrow: true,
          title: 'user_gender'.tr,
          note: AppService.to.loginUserInfo.value.gender == 0
              ? "user_unknown".tr
              : (AppService.to.loginUserInfo.value.gender == 1
                  ? "user_male".tr
                  : "user_female".tr),
          onClick: (cell) {
            AppUtil.showActionSheet(
              List<String>.from(["user_male".tr, "user_female".tr]),
              onSelected: (index) {
                if (index == 0) {
                  AppService.to.updateProfile({"gender": 1});
                } else {
                  AppService.to.updateProfile({"gender": 2});
                }
              },
            );
          },
        ),
        TDCell(
          arrow: true,
          title: 'user_birthday'.tr,
          note: AppService.to.loginUserInfo.value.birthday ??
              "user_set_birthday".tr,
          onClick: (cell) {
            TDPicker.showDatePicker(
              Get.context!,
              title: "user_select_birthday".tr,
              onConfirm: (selected) {
                Get.back();
                String birthday = DateUtil.formattedDateByString(
                    selected['year']!, selected['month']!, selected['day']!);
                AppService.to.updateProfile({"birthday": birthday});
              },
              dateStart: [1950, 01, 01],
              dateEnd: [2023, 12, 31],
              initialDate: [2012, 1, 1],
            );
          },
        ),
      ],
    );
  }
}
