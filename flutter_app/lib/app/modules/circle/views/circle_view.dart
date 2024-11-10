import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/events/events.dart';

import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/core/utils/tool/event_util.dart';

import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/models/circle.m.dart';
import '../controllers/circle_controller.dart';

class CircleView extends GetView<CircleController> {
  const CircleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('圈子分类'),
        centerTitle: true,
        elevation: 1,
        surfaceTintColor: AppColor.white,
      ),
      body: Obx(() => _buildSideBar()),
    );
  }

  Widget _buildSideBar() {
    List<Widget> parents = [];
    for (int i = 0; i < controller.circleList.value.length; i++) {
      parents.add(_leftItem(controller.circleList.value[i], i));
    }
    return Row(
      children: [
        Container(
          width: 200.rpx,
          height: Get.height,
          color: AppColor.subBg,
          child: SingleChildScrollView(
            child: Column(
              children: parents,
            ),
          ),
        ),
        Expanded(
            child: Container(
          color: AppColor.white,
          height: Get.height,
          child: controller.circleList.value.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.circleList
                        .value[controller.selectIndex.value].children!
                        .map((e) {
                      return _rightItem(e);
                    }).toList(),
                  ),
                )
              : Container(),
        ))
      ],
    );
  }

  Widget _leftItem(Circle circle, int index) {
    return GestureDetector(
      onTap: () => controller.selectIndex.value = index,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 20.rpx),
        width: 200.rpx,
        decoration: BoxDecoration(
          color: controller.selectIndex.value == index
              ? AppColor.white
              : AppColor.subBg,
          borderRadius: (controller.selectIndex.value - 1) == index
              ? BorderRadius.only(bottomRight: Radius.circular(30.rpx))
              : (controller.selectIndex.value + 1) == index
                  ? BorderRadius.only(topRight: Radius.circular(30.rpx))
                  : BorderRadius.circular(0),
        ),
        child: Text(
          circle.title!,
          style: TextStyle(
            color: controller.selectIndex.value == index
                ? AppColor.primaryColor
                : Colors.black,
            fontSize: 28.rpx,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _rightItem(Circle circle) {
    return Container(
      margin: EdgeInsets.only(left: 20.rpx, right: 20.rpx),
      padding: EdgeInsets.symmetric(horizontal: 0.rpx, vertical: 20.rpx),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.subBg,
            width: 2.rpx,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                circle.iconimage!.toCircleCachedNetworkImage(radius: 12.rpx),
                SizedBox(
                  width: 10.rpx,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      circle.title!,
                      style: TextStyle(fontSize: 28.rpx),
                    ),
                    Text(
                      "${circle.followNum!}人加入",
                      style:
                          TextStyle(fontSize: 24.rpx, color: AppColor.subTitle),
                    ),
                  ],
                )
              ],
            ),
          ),
          TDButton(
            text: controller.from.value == 'publish'
                ? '选择'
                : AppService.to.isFollowCircle(circle.id!)
                    ? "取消"
                    : "加入",
            size: TDButtonSize.small,
            type: TDButtonType.fill,
            shape: TDButtonShape.rectangle,
            theme: TDButtonTheme.light,
            onTap: () {
              if (controller.from.value == 'publish') {
                EventBusUtil.getInstance()
                    .fire(PublishSelectCircleEvent(circle));
                Get.back();
              } else {
                AppService.to.isFollowCircle(circle.id!)
                    ? controller.cancelCircle(circle.id!)
                    : controller.joinCircle(circle.id!);
              }
            },
          ),
        ],
      ),
    );
  }
}
