import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/components/close_button/close_button.dart';
import '../controllers/publish_controller.dart';

class PublishView extends GetView<PublishController> {
  const PublishView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          title: Text('publish_title'.tr),
          leading: IconButton(
            icon: const Icon(AppIcon.close),
            onPressed: () => Get.back(),
          ),
          centerTitle: true,
          actions: [
            TDButton(
              text: '发布',
              size: TDButtonSize.extraSmall,
              type: TDButtonType.fill,
              shape: TDButtonShape.round,
              theme: TDButtonTheme.primary,
              disabled: true,
              textStyle: TextStyle(fontSize: 24.rpx),
              disableTextStyle: TextStyle(fontSize: 24.rpx),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: SizedBox(
          height: Get.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: AppColor.line,
                    ),
                    TDCell(
                      arrow: true,
                      title: '选择话题',
                      note: "合适的话题，会有更多关注",
                      leftIcon: AppIcon.topic,
                      style: TDCellStyle(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          backgroundColor: Colors.white,
                          leftIconColor: AppColor.primaryColor,
                          titleStyle: const TextStyle(
                            color: AppColor.primaryColor,
                          ),
                          noteStyle: const TextStyle(
                            color: AppColor.subTitle,
                          )),
                    ),
                    _inputView(),
                    ..._publistViews(),
                    Container(
                      color: AppColor.white,
                      height: 10,
                    ),
                  ],
                ).paddingOnly(bottom: 60),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: _publishButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputView() {
    return Container(
      color: Get.isDarkMode ? Colors.black : AppColor.white,
      child: TDTextarea(
        hintText: '分享你的想法...',
        maxLines: 4,
        minLines: 4,
        onChanged: (value) {},
        textStyle: const TextStyle(fontSize: 16),
        backgroundColor: AppColor.white,
        textInputBackgroundColor: AppColor.white,
        padding: const EdgeInsets.all(20),
        bordered: false,
      ),
    );
  }

  Widget _publishButton() {
    const Color color = AppColor.primaryColor;
    final double size = 50.rpx;
    return Container(
      color: Get.isDarkMode ? Colors.black : Colors.white,
      padding: EdgeInsets.only(bottom: AppUtil.getSafeAreaHeight()),
      child: Row(
        children: [
          IconButton(
            color: color,
            onPressed: () {},
            icon: Icon(
              AppIcon.pubImage,
              size: size,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubVideo,
              size: size,
            ),
            color: color,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubAudio,
              size: size,
            ),
            color: color,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubPoll,
              size: size,
            ),
            color: color,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubEmoj,
              size: size,
            ),
            color: color,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              AppIcon.pubLink,
              size: size,
            ),
            color: color,
          ),
        ],
      ),
    );
  }

  List<Widget> _publistViews() {
    List<Widget> list = [];
    list.add(_imageListView());
    return list;
  }

  Widget _imageListView() {
    return Container(
      color: Get.isDarkMode ? Colors.black : AppColor.white,
      child: GridView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          _imageItem("https://pic.qqans.com/up/2024-5/17158197793092039.jpg"),
          _imageItem("https://pic.qqans.com/up/2024-5/17158197794093305.jpg"),
          _imageItem("https://pic.qqans.com/up/2024-5/17158197798606489.jpg"),
          _imageItem("https://pic.qqans.com/up/2024-5/17158197798606489.jpg"),
          _imageItem("https://pic.qqans.com/up/2024-5/17158197798606489.jpg"),
          _imageItem("https://pic.qqans.com/up/2024-5/17158197798606489.jpg")
        ],
      ),
    );
  }

  Widget _imageItem(String url) {
    return Container(
      child: Stack(
        children: [
          url.toCachedNetworkImageRemote(
            radius: 10,
            width: (Get.width - 40) / 3,
            height: (Get.width - 40) / 3,
          ),
          const Positioned(
            right: 3,
            top: 3,
            child: CustomCloseButton(),
          )
        ],
      ),
    );
  }
}
