import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/components/color_status_bar/color_status_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        body: _scaffoldBody(),
        bottomNavigationBar: Obx(
          () => ConvexAppBar(
            // type: BottomNavigationBarType.fixed,
            // currentIndex: controller.currentIndex.value, // 当前页
            // selectedFontSize: 24.sp, // 选中的字体大小
            // unselectedFontSize: 24.sp, // 未选中的字体大小
            initialActiveIndex: controller.currentIndex.value,
            backgroundColor: Colors.white,
            color: const Color(0xff333333),
            activeColor: AppColor.primaryColor,
            style: TabStyle.react,
            onTap: (int idx) async {
              if (idx == 2) {
                // 跳转到发布页面
                Get.toNamed(Routes.PUBLISH);
              } else {
                controller.currentIndex.value = idx;
                controller.pageController.jumpToPage(idx); // 跳转
              }
            },
            items: _generateBottomBars(), // 底部菜单导航
          ),
        ),
      ),
    );
  }

  Widget _scaffoldBody() {
    return PageView(
      controller: controller.pageController,
      physics: controller.physicsFlag.value
          ? const NeverScrollableScrollPhysics()
          : null,
      children: bodyWidget(), // tab页面主体
      // 监听滑动
      onPageChanged: (index) {
        controller.currentIndex.value = index;
      },
    );
  }

  /// tab视图内容区域
  List<Widget> bodyWidget() {
    try {
      return controller.appBottomBar
          .map((itemData) => itemData['body'] as Widget)
          .toList();
    } catch (e) {
      throw Exception('appBottomBar变量缺少body参数，errorMsg:$e');
    }
  }

  /// 生成底部菜单导航
  List<TabItem> _generateBottomBars() {
    try {
      return controller.appBottomBar.map<TabItem>((itemData) {
        return TabItem(
          icon: itemData['icon'] as IconData,
          title: itemData['title'] as String,
        );
      }).toList();
    } catch (e) {
      throw Exception('appBottomBar数据缺少参数、或字段类型不匹配, errorMsg:$e');
    }
  }
}
