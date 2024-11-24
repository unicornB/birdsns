import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/notification.m.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:flutter_app/app/core/utils/tool/date_util.dart';
import 'package:flutter_app/app/modules/home/controllers/messages/notification_controller.dart';

import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../../core/components/custom_icons/app_icon.dart';

class NotificationPage extends GetView<NotificationController> {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.instance.background,
      body: RefreshIndicator(
        color: ColorPalettes.instance.primary,
        backgroundColor: ColorPalettes.instance.background,
        onRefresh: () async {
          controller.onRefresh();
        },
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            controller: controller.scrollController,
            children: [
              ..._listView(),
              controller.notificationList.value.isEmpty
                  ? Container(
                      height: Get.height,
                      color: ColorPalettes.instance.background,
                      child: TDEmpty(
                        type: TDEmptyType.plain,
                        emptyText: '暂无通知',
                        emptyTextColor: ColorPalettes.instance.firstText,
                        image: Container(
                          margin: EdgeInsets.only(top: 50.rpx),
                          width: 100,
                          height: 100,
                          child: Icon(
                            AppIcon.empty,
                            size: 100.rpx,
                            color: ColorPalettes.instance.firstText,
                          ),
                        ),
                      ),
                    )
                  : controller.loading.value
                      ? Container(
                          alignment: Alignment.center,
                          child: const TDLoading(
                            size: TDLoadingSize.small,
                            icon: TDLoadingIcon.circle,
                            text: '加载中…',
                            axis: Axis.horizontal,
                          ),
                        )
                      : controller.hasMore.value
                          ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10.rpx),
                              alignment: Alignment.center,
                              child: Text(
                                "上拉加载更多",
                                style: TextStyle(
                                    color: AppColor.subTitle, fontSize: 26.rpx),
                              ),
                            )
                          : Container(
                              color: ColorPalettes.instance.background,
                              padding: EdgeInsets.symmetric(vertical: 10.rpx),
                              alignment: Alignment.center,
                              child: Text(
                                "没有更多了",
                                style: TextStyle(
                                    color: ColorPalettes.instance.secondText,
                                    fontSize: 26.rpx),
                              ),
                            ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listView() {
    List<Widget> list = [];
    for (int i = 0; i < controller.notificationList.value.length; i++) {
      list.add(_listItem(controller.notificationList.value[i], i));
    }
    return list;
  }

  Widget _listItem(Notifications notification, int index) {
    var isDarkStyle = ColorPalettes.instance.isDark();
    return GestureDetector(
      onTap: () {
        controller.toDetail(notification, index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 20.rpx),
        margin: EdgeInsets.only(top: isDarkStyle ? 0 : 10.rpx),
        color: ColorPalettes.instance.background,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                badges.Badge(
                  showBadge: notification.status == '0',
                  badgeStyle: badges.BadgeStyle(
                      badgeColor: const Color(0xff4CE417),
                      padding: EdgeInsets.all(8.rpx)),
                  position: badges.BadgePosition.custom(
                    bottom: 6.rpx,
                    end: 9.rpx,
                  ),
                  child: notification.avatar!.toCircleCachedNetworkImage(
                    width: 100.rpx,
                    height: 100.rpx,
                    radius: 50.rpx,
                  ),
                ),
                SizedBox(
                  width: 20.rpx,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notification.nickname!,
                      style: TextStyle(
                        fontSize: 28.rpx,
                        color: ColorPalettes.instance.firstText,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10.rpx,
                    ),
                    Text(
                      notification.extra!,
                      style: TextStyle(
                        fontSize: 24.rpx,
                        color: ColorPalettes.instance.thirdText,
                      ),
                    )
                  ],
                )
              ],
            ),
            Text(
              DateUtil.formatTime(notification.createtime!),
              style: TextStyle(
                fontSize: 24.rpx,
                color: ColorPalettes.instance.thirdText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
