import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/color_palettes.dart';
import '../controllers/home_controller.dart';
import 'package:badges/badges.dart' as badges;

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scaffoldBody(),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          notchMargin: 0,
          padding: EdgeInsets.symmetric(vertical: 0.rpx),
          height: 100.rpx,
          shape: const CircularNotchedRectangle(),
          color: ColorPalettes.instance.pure,
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
                  width: 50,
                  height: 34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.rpx),
                    color: ColorPalettes.instance.primary,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              Obx(
                () => badges.Badge(
                  showBadge: AppService.to.notificationCount.value > 0,
                  badgeStyle: badges.BadgeStyle(
                      padding: EdgeInsets.all(
                    AppService.to.notificationCount.value < 10 ? 10.rpx : 6.rpx,
                  )),
                  badgeContent: Text(
                    '${AppService.to.notificationCount.value}',
                    style: TextStyle(color: Colors.white, fontSize: 24.rpx),
                  ),
                  child: _bottomNavigationBarItem(
                    icon: "assets/images/bottom/message_line.svg",
                    activeIcon: "assets/images/bottom/message_fill.svg",
                    title: "消息",
                    active: controller.currentIndex.value == 2,
                    onTap: () {
                      controller.currentIndex.value = 2;
                      controller.pageController.jumpToPage(2);
                    },
                  ),
                ),
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
      width: 45.rpx,
      height: 45.rpx,
      color: active
          ? ColorPalettes.instance.primary
          : ColorPalettes.instance.secondText,
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
                color: active
                    ? ColorPalettes.instance.primary
                    : ColorPalettes.instance.secondText,
                fontSize: 24.rpx),
          )
        ],
      ),
    );
  }
}
