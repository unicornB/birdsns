import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/components/custom_icons/svg_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/service/app_service.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/mine_controller.dart';

class MinePage extends GetView<MineController> {
  const MinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      color: AppColor.primaryColor,
      child: Scaffold(
        body: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            children: [
              Obx(() => headerView()),
              SizedBox(
                height: 30.rpx,
              ),
              _menuView(),
              SizedBox(
                height: 20.rpx,
              ),
              _toolView(),
              SizedBox(
                height: 20.rpx,
              ),
              _toolView()
            ],
          ),
        ),
      ),
    );
  }

  //background-image: linear-gradient(to top, #4481eb 0%, #04befe 100%);
  Widget headerView() {
    return Container(
      height: 330.rpx,
      width: double.infinity,
      color: AppColor.primaryColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TDAvatar(
                  size: TDAvatarSize.large,
                  type: TDAvatarType.normal,
                  avatarUrl: AppService.to.loginUserInfo.value.avatar ?? "",
                  avatarSize: 160.rpx,
                  avatarDisplayBorder: 10,
                  onTap: () {
                    if (AppService.to.isLogined.value) {
                      Get.toNamed(Routes.USERINFO);
                    } else {
                      Get.toNamed(Routes.LOGIN);
                    }
                  },
                ),
                SizedBox(
                  height: 20.rpx,
                ),
                Text(AppService.to.loginUserInfo.value.nickname ?? "未登录"),
                SizedBox(
                  height: 20.rpx,
                ),
                _countView()
              ],
            ),
          ),
          Positioned(
            right: 30.rpx,
            top: 20.rpx,
            child: SvgIcon.settings,
          )
        ],
      ),
    );
  }

  Widget _countView() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.rpx),
                  child: Text(
                    "100 ",
                    style: TextStyle(
                      fontSize: 28.rpx,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "获赞",
                  style: TextStyle(
                    fontSize: 28.rpx,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 2.rpx,
            height: 20.rpx,
            color: Colors.white,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.rpx),
                  child: Text(
                    "100 ",
                    style: TextStyle(
                      fontSize: 28.rpx,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "关注",
                  style: TextStyle(
                    fontSize: 28.rpx,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 2.rpx,
            height: 20.rpx,
            color: Colors.white,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5.rpx),
                  child: Text(
                    "100 ",
                    style: TextStyle(
                      fontSize: 28.rpx,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "粉丝",
                  style: TextStyle(
                    fontSize: 28.rpx,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.rpx),
      child: GridView(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        children: [
          _menuItem(
            iconData: AppIcon.posts,
            title: "帖子",
            color: const Color(0xff358BFC),
          ),
          _menuItem(
            iconData: AppIcon.comment,
            title: "评论",
            color: const Color(0xffFF6545),
          ),
          _menuItem(
            iconData: AppIcon.favorites,
            title: "收藏",
            color: const Color(0xffFFA73E),
          ),
          _menuItem(
            iconData: AppIcon.good,
            title: "赞过",
            color: const Color(0xff91B3FF),
          ),
          _menuItem(
            iconData: AppIcon.up,
            title: "赞过",
            color: const Color(0xffF5283A),
          ),
        ],
      ),
    );
  }

  _toolView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.rpx),
      padding: EdgeInsets.only(top: 20.rpx),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.rpx),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.rpx, top: 0.rpx, bottom: 10.rpx),
            child: Text(
              "共建社区",
              style: TextStyle(
                fontSize: 30.rpx,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5),
            children: [
              _menuItem(
                iconData: AppIcon.posts,
                title: "帖子",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.comment,
                title: "评论",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.favorites,
                title: "收藏",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.good,
                title: "赞过",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.up,
                title: "赞过",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.posts,
                title: "帖子",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.comment,
                title: "评论",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.favorites,
                title: "收藏",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.good,
                title: "赞过",
                color: const Color(0xff358BFC),
              ),
              _menuItem(
                iconData: AppIcon.up,
                title: "赞过",
                color: const Color(0xff358BFC),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _menuItem({
    IconData? iconData,
    String? title,
    Color? color,
    double? size = 32,
  }) {
    return Column(
      children: [
        Icon(iconData, color: color, size: size),
        SizedBox(
          height: 10.rpx,
        ),
        Text(
          title!,
          style: TextStyle(fontSize: 26.rpx),
        ),
      ],
    );
  }
}
