import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/modules/home/views/pages/message_pages/chatlist_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/message_pages/notification_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/components/app_bar/app_bar.dart';
import '../../../../core/components/custom_arcIndicator/custom_arcIndicator.dart';
import '../../../../core/constants/colors/app_color.dart';
import '../../../../core/theme/color_palettes.dart';
import '../../controllers/mesage_controller.dart';

class MessagePage extends GetView<MesageController> {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: commonAppBar(
          backgroundColor: ColorPalettes.instance.pure,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(108.rpx),
            child: _appbarWidget(),
          ),
          iconDark: false,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _appbarWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.rpx),
      child: Container(
        alignment: Alignment.center,
        child: TabBar(
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
          isScrollable: true,
          tabAlignment: TabAlignment.center,
          tabs: [
            Tab(
              child: Text(
                "通知",
                style: TextStyle(
                  fontSize: 32.rpx,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Tab(
              child: Text(
                "私信",
                style: TextStyle(
                  fontSize: 32.rpx,
                  fontWeight: FontWeight.normal,
                ),
              ),
            )
          ],
          indicatorSize: TabBarIndicatorSize.label,
          dividerColor: Colors.transparent,
          controller: controller.tabController,
          labelColor: ColorPalettes.instance.primary,
          unselectedLabelColor: ColorPalettes.instance.secondText,
          indicator: CustomArcIndicator(
            color: ColorPalettes.instance.primary,
          ),
          indicatorWeight: 1,
          onTap: (index) {
            controller.tabIndex.value = index;
          },
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      leadingWidth: 0,
      titleSpacing: 0,
      title: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(top: 10.rpx),
        child: Container(
          alignment: Alignment.center,
          child: TabBar(
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
            isScrollable: true,
            tabAlignment: TabAlignment.center,
            tabs: [
              Tab(
                child: Text(
                  "通知",
                  style: TextStyle(
                    fontSize: 32.rpx,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "私信",
                  style: TextStyle(
                    fontSize: 32.rpx,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              )
            ],
            indicatorSize: TabBarIndicatorSize.label,
            dividerColor: Colors.transparent,
            controller: controller.tabController,
            indicator: CustomArcIndicator(color: AppColor.primaryColor),
            indicatorWeight: 1,
            onTap: (index) {
              controller.tabIndex.value = index;
            },
          ),
        ),
      ),
    );
  }

  TabBarView _buildBody() {
    return TabBarView(
      controller: controller.tabController,
      children: const [
        NotificationPage(),
        ChatlistPage(),
      ],
    );
  }
}
