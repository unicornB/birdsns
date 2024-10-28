import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/components/color_status_bar/color_status_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scaffoldBody(),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          notchMargin: 0,
          padding: EdgeInsets.symmetric(vertical: 1.rpx),
          height: 100.rpx,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _bottomNavigationBarItem(
                icon: "assets/images/bottom/home_line.svg",
                activeIcon: "assets/images/bottom/home_fill.svg",
                title: "首页",
                active: controller.currentIndex.value == 0,
                onTap: () {
                  controller.currentIndex.value = 0;
                  controller.pageController.jumpToPage(0);
                },
              ),
              _bottomNavigationBarItem(
                icon: "assets/images/bottom/shopping_line.svg",
                activeIcon: "assets/images/bottom/shopping_fill.svg",
                title: "购物",
                active: controller.currentIndex.value == 1,
                onTap: () {
                  controller.currentIndex.value = 1;
                  controller.pageController.jumpToPage(1);
                },
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.PUBLISH);
                },
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.rpx),
                    color: AppColor.primaryColor,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              _bottomNavigationBarItem(
                icon: "assets/images/bottom/message_line.svg",
                activeIcon: "assets/images/bottom/message_fill.svg",
                title: "消息",
                active: controller.currentIndex.value == 2,
                onTap: () {
                  controller.currentIndex.value = 2;
                  controller.pageController.jumpToPage(2);
                },
              ),
              _bottomNavigationBarItem(
                icon: "assets/images/bottom/user_line.svg",
                activeIcon: "assets/images/bottom/user_fill.svg",
                title: "我的",
                active: controller.currentIndex.value == 3,
                onTap: () {
                  controller.currentIndex.value = 3;
                  controller.pageController.jumpToPage(3);
                },
              ),
            ],
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

  Widget _bottomNavigationBarItem({
    String? icon,
    String? activeIcon,
    String? title,
    bool? active = false,
    void Function()? onTap,
  }) {
    final Widget svg = SvgPicture.asset(
      active! ? activeIcon! : icon!,
      width: 50.rpx,
      height: 50.rpx,
      color: active ? Colors.blue : Colors.grey,
    );
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(height: 8.rpx),
          svg,
          Text(
            title ?? '',
            style: TextStyle(
                color: active ? AppColor.primaryColor : Colors.grey,
                fontSize: 24.rpx),
          )
        ],
      ),
    );
  }
}
