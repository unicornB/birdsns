import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../core/components/no_over_scroll_behavior/no_over_scroll_behavior.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollConfiguration(
        behavior: NoOverScrollBehavior(),
        child: ExtendedNestedScrollView(
          controller: controller.scrollController,
          onlyOneScrollInBody: true,
          pinnedHeaderSliverHeightBuilder: () => pinnedHeaderHeight,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              Obx(() => _buildAppBar()),
            ];
          },
          body: Obx(
            () => TabBarView(
              controller: controller.tabController,
              children: controller.navPages.value,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      scrolledUnderElevation: 0.0,
      toolbarHeight: 88.w,
      backgroundColor: ColorPalettes.instance.card,
      expandedHeight: controller.expandedHeight,
      title: _titleBar(),
      automaticallyImplyLeading: false,
      pinned: true,
      elevation: 0,
      titleSpacing: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:
            Colors.white.withOpacity(controller.titleBarAlpha.value),
      ),
      flexibleSpace: _flexibleSpace(Get.context!),
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 78.w),
        child: _tabBar(),
      ),
    );
  }

  Widget _titleBar() {
    var isDarkStyle = ColorPalettes.instance.isDark();
    return PreferredSize(
      preferredSize: Size(double.infinity, 88.w),
      child: Container(
        width: double.infinity,
        height: 88.w,
        color: ColorPalettes.instance.card
            .withOpacity(controller.titleBarAlpha.value),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 32.w),
            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  color: isDarkStyle
                      ? Colors.white
                      : Color.fromARGB(
                          255,
                          255 - (255 * controller.titleBarAlpha.value).toInt(),
                          255 - (255 * controller.titleBarAlpha.value).toInt(),
                          255 - (255 * controller.titleBarAlpha.value).toInt()),
                )),
            SizedBox(width: 32.w),
            Opacity(
              opacity: controller.titleBarAlpha.value,
              child: Row(
                children: [
                  controller.profile.value.avatar != null
                      ? Container(
                          width: 80.rpx,
                          height: 80.rpx,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80.rpx / 2),
                            border: Border.all(
                              color: Colors.white,
                              width: 1,
                            ),
                          ),
                          child: ClipOval(
                            //圆角图片
                            child: controller.profile.value.avatar!
                                .toCircleCachedNetworkImage(
                              width: 80.rpx,
                              height: 80.rpx,
                              radius: 40.rpx,
                            ),
                          ),
                        )
                      : Container(),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    controller.profile.value.nickname ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 32.w,
                      color: ColorPalettes.instance.firstText,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _flexibleSpace(BuildContext context) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Stack(
        children: [
          _blurBackground(),
          _cardBackground(),
          _flexibleContent(context)
        ],
      ),
    );
  }

  Widget _blurBackground() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: controller.profile.value.bgImg?.toCachedNetworkImage(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  Widget _cardBackground() {
    return Container(
      margin: EdgeInsets.only(top: 280.w),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: ColorPalettes.instance.card,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.w),
          topRight: Radius.circular(32.w),
        ),
      ),
    );
  }

  Widget _flexibleContent(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 56.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VisibilityDetector(
                  key: const Key("user_center_page"),
                  onVisibilityChanged: (VisibilityInfo info) {
                    if (info.visibleBounds.bottom > 0) {
                      controller.nicknameWidgetBottom.value =
                          info.visibleBounds.bottom;
                    }
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 220.w),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Hero(
                              tag: "user_avatar",
                              child: controller.profile.value.avatar != null
                                  ? Container(
                                      width: 130.rpx,
                                      height: 130.rpx,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(130.rpx / 2),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                      child: controller.profile.value.avatar!
                                          .toCircleCachedNetworkImage(
                                        width: 130.rpx,
                                        height: 130.rpx,
                                        radius: 65.rpx,
                                      ),
                                    )
                                  : Container(),
                            ),
                            _editButton(),
                          ],
                        ),
                        SizedBox(height: 16.w),
                        Text(
                          controller.profile.value.nickname ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 44.w,
                            color: ColorPalettes.instance.firstText,
                          ),
                        ),
                      ])),
              SizedBox(
                height: 16.w,
              ),
              Text(
                controller.profile.value.bio ?? "",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 26.w,
                  color: ColorPalettes.instance.secondText,
                ),
              ),
              SizedBox(
                height: 32.w,
              ),
              Row(
                children: [
                  _userAttributesItem("获赞", "100"),
                  SizedBox(
                    width: 48.w,
                  ),
                  _userAttributesItem(
                      "关注", controller.profile.value.fans?.toString(),
                      onClick: () {}),
                  SizedBox(
                    width: 48.w,
                  ),
                  _userAttributesItem(
                      "粉丝", controller.profile.value.fans?.toString(),
                      onClick: () {}),
                ],
              ),
              SizedBox(
                height: 32.w,
              ),
            ],
          ),
        ),
        Container(
          height: 12.w,
          color: ColorPalettes.instance.background,
        ),
      ],
    );
  }

  Widget _userAttributesItem(String name, String? count,
      {VoidCallback? onClick}) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (onClick != null) {
          onClick();
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            count ?? "--",
            style: TextStyle(
              fontSize: 32.w,
              color: ColorPalettes.instance.secondText,
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            name,
            style: TextStyle(
              fontSize: 28.w,
              color: ColorPalettes.instance.thirdText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      child: TabBar(
        controller: controller.tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        isScrollable: false,
        indicator: UnderlineTabIndicator(
          borderRadius: BorderRadius.circular(4.w),
          insets: EdgeInsets.symmetric(
              horizontal: controller.tabs.length == 4 ? 72.w : 160.w),
          borderSide:
              BorderSide(width: 4.w, color: ColorPalettes.instance.primary),
        ),
        labelPadding: const EdgeInsets.all(0),
        labelColor: ColorPalettes.instance.primary,
        unselectedLabelColor: ColorPalettes.instance.secondText,
        labelStyle: TextStyle(fontSize: 28.rpx, fontWeight: FontWeight.bold),
        unselectedLabelStyle:
            TextStyle(fontSize: 28.rpx, fontWeight: FontWeight.normal),
        //未选中时标签的颜色
        onTap: (int index) {
          controller.jumpToPage(index);
        },
        tabs: controller.tabs.value.map((tab) {
          return Container(
            height: 72.w,
            alignment: Alignment.center,
            child: Text(
              tab,
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _editButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 80.w),
        width: controller.isSelf() ? 160.w : 120.rpx,
        height: 56.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: ColorPalettes.instance.primary,
            borderRadius: BorderRadius.circular(28.w)),
        child: Text(
          controller.isSelf() ? "编辑资料" : "关注",
          style: TextStyle(fontSize: 28.w, color: Colors.white),
        ),
      ),
    );
  }
}
