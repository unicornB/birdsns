import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/profile_api.dart';
import 'package:flutter_app/app/core/models/profile.m.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/modules/profile/views/pages/collect_page.dart';
import 'package:flutter_app/app/modules/profile/views/pages/comment_page.dart';
import 'package:flutter_app/app/modules/profile/views/pages/like_page.dart';
import 'package:flutter_app/app/modules/profile/views/pages/posts_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
    with GetTickerProviderStateMixin {
  final id = 0.obs;
  final profile = Profile.fromJson({}).obs;

  final titleBarAlpha = 0.0.obs;
  final nicknameWidgetBottom = 0.0.obs;
  ScrollController scrollController = ScrollController();
  final titleBarBottom = 0.0.obs;
  final expandedHeight = 630.w;
  final tabs = ['创作', '喜欢'].obs;
  final RxList<Widget> navPages = <Widget>[].obs;
  late TabController tabController;
  final index = 0.obs;
  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments['id'];
    tabController =
        TabController(initialIndex: 0, vsync: this, length: tabs.length);
    navPages.value = [
      Container(),
      Container(),
    ];
    navPages.refresh();
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
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        index.value = tabController.index;
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getData() async {
    var res = await ProfileApi.info(id.value);
    profile.value = Profile.fromJson(res['data']);
    if (isSelf()) {
      tabs.value = ['创作(20)', '喜欢(10)', '评论(10)', '收藏(20)'];
      navPages.value = [
        PostsPage(
          userId: profile.value.id!,
        ),
        const LikePage(),
        const CommentPage(),
        const CollectPage()
      ];
      navPages.refresh();
    } else {
      tabs.value = ['创作', '喜欢'];
      navPages.value = [
        PostsPage(
          userId: profile.value.id!,
        ),
        const LikePage(),
      ];
      navPages.refresh();
    }
    tabController = TabController(
        initialIndex: index.value, vsync: this, length: tabs.length);
  }

  bool isSelf() {
    return profile.value.id == AppService.to.loginUserInfo.value.id;
  }

  void jumpToPage(int index) {
    tabController.animateTo(index);
  }
}
