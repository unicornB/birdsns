import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/posts/audio_item.dart';
import 'package:flutter_app/app/core/components/posts/image_item.dart';
import 'package:flutter_app/app/core/components/posts/text_item.dart';
import 'package:flutter_app/app/core/components/posts/video_item.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/enums/posts_type.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';

import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../routes/app_pages.dart';
import '../../controllers/image_page_controller.dart';
import '../../controllers/rec_page_controller.dart';

class ImagePage extends GetView<ImagePageController> {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.onRefresh,
        child: Obx(
          () => ListView(
            shrinkWrap: true,
            controller: controller.scrollController,
            children: [
              // bannerView(controller),
              // SizedBox(
              //   height: 20.sp,
              // ),
              // menuView(controller),
              ...listviews(),
              controller.loading.value
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
                          padding: EdgeInsets.symmetric(vertical: 10.rpx),
                          alignment: Alignment.center,
                          child: Text(
                            "没有更多了",
                            style: TextStyle(
                                color: AppColor.subTitle, fontSize: 26.rpx),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItemView(Feed feed) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (feed.type == PostsType.video.name)
            VideoItem(
              feed: feed,
              onTap: (id) {
                Get.toNamed(Routes.POSTS, arguments: {"id": id});
              },
              onCommentTap: (id) {
                log("onCommentTap");
              },
            ),
          if (feed.type == PostsType.audio.name)
            AudioItem(
              feed: feed,
              onTap: (id) {
                Get.toNamed(Routes.POSTS, arguments: {"id": id});
              },
            ),
          if (feed.type == PostsType.image.name)
            ImageItem(
              feed: feed,
              onTap: (id) {
                Get.toNamed(Routes.POSTS, arguments: {"id": id});
              },
            ),
          if (feed.type == PostsType.text.name)
            TextItem(
              feed: feed,
              onTap: (id) {
                Get.toNamed(Routes.POSTS, arguments: {"id": id});
              },
            )
        ],
      ),
    );
  }

  Widget bannerView(RecPageController controller) {
    return SizedBox(
      height: 350.sp,
      child: controller.bannerList.value.isNotEmpty
          ? Swiper(
              autoplay: true,
              itemCount: controller.bannerList.value.length,
              loop: true,
              duration: 600,
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: TDSwiperPagination.dotsBar,
              ),
              itemBuilder: (BuildContext context, int index) {
                return TDImage(
                  imgUrl: controller.bannerList.value[index].image!,
                );
              },
            )
          : Container(),
    );
  }

  Widget menuView(RecPageController controller) {
    return GridView.count(
      crossAxisCount: 5,
      mainAxisSpacing: 10.sp,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: controller.menuList.value
          .map(
            (item) => Column(
              children: [
                item.iconimage!
                    .toCachedNetworkImageRemote(width: 110.sp, height: 110.sp),
                Text(
                  item.name!,
                  style: TextStyle(fontSize: 26.sp),
                )
              ],
            ),
          )
          .toList(),
    );
  }

  List<Widget> listviews() {
    return controller.feedsList.value.map((element) {
      return _listItemView(element);
    }).toList();
  }
}
