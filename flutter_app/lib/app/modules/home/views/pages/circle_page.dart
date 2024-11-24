import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/circle.m.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import '../../controllers/circle_page_controller.dart';
import 'package:flutter_app/app/routes/app_pages.dart';

import 'package:get/get.dart';

class CirclePage extends GetView<CirclePageController> {
  const CirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.instance.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _myCircleTitle(),
            _myCircle(),
            SizedBox(
              height: 10.rpx,
            ),
            _myHistoryTitle("最近浏览", "查看更多"),
            _myHistory(),
            SizedBox(
              height: 10.rpx,
            ),
            _myHistoryTitle(
              "热门圈子",
              "圈子分类",
              onTap: () {
                Get.toNamed(Routes.CIRCLE);
              },
            ),
            _hostCircleList()
          ],
        ),
      ),
    );
  }

  Widget _myCircleTitle() {
    return Container(
      color: ColorPalettes.instance.background,
      padding: EdgeInsets.only(top: 20.rpx, left: 20.rpx, right: 20.rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "我的圈子",
            style: TextStyle(
              fontSize: 28.rpx,
              fontWeight: FontWeight.bold,
              color: ColorPalettes.instance.firstText,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.add,
                color: ColorPalettes.instance.primary,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.CIRCLECREATE);
                },
                child: Text(
                  "创建圈子",
                  style: TextStyle(
                    color: ColorPalettes.instance.primary,
                    fontSize: 28.rpx,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _myCircle() {
    return Container(
      width: Get.width,
      color: ColorPalettes.instance.background,
      padding: EdgeInsets.only(left: 20.rpx, right: 20.rpx, bottom: 20.rpx),
      child: Obx(() => Wrap(
            children: controller.mylist.value.map((circle) {
              return _myCircleItem(circle);
            }).toList(),
          )),
    );
  }

  Widget _myCircleItem(Circle circle) {
    return Container(
      width: 355.rpx,
      margin: EdgeInsets.only(top: 20.rpx),
      child: Row(
        mainAxisSize: MainAxisSize.min, // 设置主轴方向尺寸为最小
        children: <Widget>[
          Stack(
            children: [
              circle.iconimage!.toCircleCachedNetworkImage(radius: 16.rpx)
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 20.rpx, right: 20.rpx),
              child: Text(
                circle.title!,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis, // 超出部分显示省略号
                style: TextStyle(
                  fontSize: 26.rpx,
                  fontWeight: FontWeight.w500,
                  color: ColorPalettes.instance.firstText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _myHistoryTitle(String title, String subtitle,
      {void Function()? onTap}) {
    return Container(
      color: ColorPalettes.instance.background,
      padding: EdgeInsets.only(top: 20.rpx, left: 20.rpx, right: 20.rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 28.rpx,
              fontWeight: FontWeight.bold,
              color: ColorPalettes.instance.firstText,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                      color: ColorPalettes.instance.secondText,
                      fontSize: 24.rpx),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20.rpx,
                  color: ColorPalettes.instance.secondText,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _myHistory() {
    return Container(
      color: ColorPalettes.instance.background,
      width: double.infinity,
      padding: EdgeInsets.only(
          left: 20.rpx, right: 20.rpx, bottom: 20.rpx, top: 20.rpx),
      child: Wrap(
        children: [
          _myHistoryItem(),
          _myHistoryItem(),
          _myHistoryItem(),
          _myHistoryItem(),
          _myHistoryItem()
        ],
      ),
    );
  }

  Widget _myHistoryItem() {
    return Container(
      width: 142.rpx,
      height: 172.rpx,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          "https://pic.qqans.com/up/2024-4/202447838173056.jpg"
              .toCachedNetworkImageRemote(
                  width: 122.rpx, height: 122.rpx, radius: 10.rpx),
          SizedBox(
            height: 10.rpx,
          ),
          Text(
            "历史记录",
            style: TextStyle(
              fontSize: 24.rpx,
              color: ColorPalettes.instance.secondText,
            ),
          )
        ],
      ),
    );
  }

  Widget _hostCircleList() {
    return Container(
      color: ColorPalettes.instance.background,
      child: Obx(
        () => Column(
          children: controller.recList.value.map((circle) {
            return _hotCircleItem(circle);
          }).toList(),
        ),
      ),
    );
  }

  Widget _hotCircleItem(Circle circle) {
    return Container(
      color: ColorPalettes.instance.background,
      padding: EdgeInsets.only(
          top: 20.rpx, left: 20.rpx, right: 20.rpx, bottom: 20.rpx),
      child: Row(
        children: [
          circle.iconimage!.toCircleCachedNetworkImage(
            width: 122.rpx,
            height: 122.rpx,
            radius: 10.rpx,
          ),
          SizedBox(
            width: 20.rpx,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  circle.title!,
                  style: TextStyle(
                    fontSize: 26.rpx,
                    fontWeight: FontWeight.bold,
                    color: ColorPalettes.instance.firstText,
                  ),
                ),
                SizedBox(
                  height: 10.rpx,
                ),
                Text(
                  "${circle.followNum} 人加入",
                  style: TextStyle(
                    fontSize: 24.rpx,
                    color: ColorPalettes.instance.thirdText,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
