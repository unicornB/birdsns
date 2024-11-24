import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/profile_api.dart';
import 'package:flutter_app/app/core/models/profile.m.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final id = 0.obs;
  final profile = Profile.fromJson({}).obs;

  final titleBarAlpha = 0.0.obs;
  final nicknameWidgetBottom = 0.0.obs;
  ScrollController scrollController = ScrollController();
  final titleBarBottom = 0.0.obs;
  final expandedHeight = 660.w;
  final tabs = ['创作', '喜欢', '评论', '收藏'].obs;
  late TabController tabController;
  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments['id'];
    tabController =
        TabController(initialIndex: 0, vsync: this, length: tabs.length);
  }

  @override
  void onReady() {
    super.onReady();
    getData();
    titleBarBottom.value = MediaQuery.of(Get.context!).padding.top + 88.w;
    scrollController.addListener(() {
      double maxScrollOffset =
          nicknameWidgetBottom.value - titleBarBottom.value;
      double fraction =
          max(0, min(1, scrollController.offset / maxScrollOffset));
      titleBarAlpha.value = fraction;
      debugPrint("titleBarAlpha:---------------- ${titleBarAlpha.value}");
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData() async {
    var res = await ProfileApi.info(2);
    profile.value = Profile.fromJson(res['data']);
  }

  bool isSelf() {
    return profile.value.id == AppService.to.loginUserInfo.value.id;
  }
}
