import 'package:flutter/material.dart';
import 'package:flutter_app/app/modules/home/views/pages/home_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/message_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/mine_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/pub_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/square_page.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

import '../../../core/components/custom_icons/app_icon.dart';
import '../../../core/events/switch_tabbar_event.dart';
import '../../../core/utils/tool/event_util.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final currentIndex = 0.obs; // 接收bar当前点击索引
  final physicsFlag = true.obs; // 是否禁止左右滑动跳转tab
  late PageController pageController;
  final List<Map<String, dynamic>> appBottomBar = [
    {
      'title': '首页',
      'icon': AppIcon.home,
      'body': const HomePage(),
      'miidle': false,
    },
    {
      'title': '购物',
      'icon': AppIcon.square,
      'body': const SquarePage(),
      'miidle': false,
    },
    {
      'title': '消息',
      'icon': AppIcon.message,
      'body': const MessagePage(),
      'miidle': false,
    },
    {
      'title': '我的',
      'icon': AppIcon.mine,
      'body': const MinePage(),
      'miidle': false,
    },
  ];
  @override
  void onInit() {
    super.onInit();
    pageController =
        PageController(initialPage: currentIndex.value, keepPage: true);
    EventBusUtil.getInstance().on<SwitchTabbarEvent>().listen((event) {
      currentIndex.value = event.index;
      pageController.jumpToPage(event.index);
    });
  }

  @override
  void onReady() {
    super.onReady();
    //Get.toNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
