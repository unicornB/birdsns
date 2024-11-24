import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/app_bar/app_bar.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';

import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/modules/home/views/pages/circle_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/find_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/follow_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/image_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/nearby_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/rec_page.dart';
import 'package:flutter_app/app/modules/home/views/pages/video_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/components/custom_arcIndicator/custom_arcIndicator.dart';
import '../../../../core/theme/color_palettes.dart';
import '../../controllers/home_page_controller.dart';
import 'hot_page.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return ColoredStatusBar(
  //     child: Scaffold(
  //       appBar: PreferredSize(
  //         preferredSize: const Size.fromHeight(50),
  //         child: AppBar(
  //           leadingWidth: 0,
  //           titleSpacing: 0,
  //           title: Obx(() => _appbarWidget()),
  //           actions: [
  //             IconButton(
  //               padding: EdgeInsets.zero,
  //               onPressed: () {},
  //               icon: const Icon(AppIcon.search),
  //             )
  //           ],
  //         ),
  //       ),
  //       body: _buildBody(),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    var isDarkStyle = ColorPalettes.instance.isDark();
    return Obx(
      () => ColoredStatusBar(
        brightness: isDarkStyle ? Brightness.dark : Brightness.light,
        color: ColorPalettes.instance.pure,
        child: Scaffold(
          appBar: commonAppBar(
            backgroundColor: ColorPalettes.instance.pure,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(108.rpx),
              child: _appbarWidget(),
            ),
            iconDark: false,
          ),
          backgroundColor: ColorPalettes.instance.background,
          body: _buildBody(),
        ),
      ),
    );
  }

  Widget _appbarWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 10.rpx),
      child: Container(
        alignment: Alignment.centerLeft,
        child: TabBar(
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: titleBars(),
          indicatorSize: TabBarIndicatorSize.label,
          indicator: CustomArcIndicator(color: ColorPalettes.instance.primary),
          dividerColor: Colors.transparent,
          labelColor: ColorPalettes.instance.primary,
          unselectedLabelColor: ColorPalettes.instance.secondText,
          controller: controller.tabController,
          indicatorWeight: 1,
          onTap: (index) {
            controller.tabIndex.value = index;
          },
        ),
      ),
    );
  }

  List<Widget> titleBars() {
    List<Widget> titles = [];
    for (int i = 0; i < controller.tabValues.length; i++) {
      titles.add(Tab(
        child: Text(
          controller.tabValues[i],
          style: TextStyle(
            fontSize: controller.tabIndex.value == i ? 32.rpx : 30.rpx,
            fontWeight: controller.tabIndex.value == i
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ));
    }
    return titles;
  }

  Widget _buildBody() {
    return _tabbarViews();
  }

  TabBarView _tabbarViews() {
    return TabBarView(
      controller: controller.tabController,
      children: const [
        CirclePage(),
        FollowPage(),
        RecPage(),
        NearbyPage(),
        HotPage(),
        VideoPage(),
        ImagePage(),
        FindPage(),
      ],
    );
  }
}
