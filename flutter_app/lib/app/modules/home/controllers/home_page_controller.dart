import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController
    with GetTickerProviderStateMixin {
  final tabValues = ['圈子', '关注', '推荐', '城市', '热门', '视频', '图文', '发现'].obs;
  late TabController tabController;
  final tabIndex = 2.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: tabValues.length, //Tab页数量
      vsync: this,
      initialIndex: tabIndex.value,
    );
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
