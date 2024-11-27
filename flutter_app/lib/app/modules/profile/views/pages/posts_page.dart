import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../../core/components/posts/posts_list.dart';
import '../../../../core/components/skeletons/feeds_skeleton.dart';
import '../../../../core/models/feed.m.dart';
import '../../controllers/posts_page_controller.dart';

class PostsPage extends GetView<PostsPageController> {
  PostsPage({super.key, required this.userId}) {
    controller.userId.value = userId;
    log("PostsPage userId: $userId");
  }
  final int userId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalettes.instance.background,
      body: Obx(
        () => controller.feedsList.value.isNotEmpty
            ? ListView(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                controller: controller.scrollController,
                children: [
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
                                    color: ColorPalettes.instance.secondText,
                                    fontSize: 26.rpx),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 10.rpx),
                              alignment: Alignment.center,
                              child: Text(
                                "没有更多了",
                                style: TextStyle(
                                  color: ColorPalettes.instance.secondText,
                                  fontSize: 26.rpx,
                                ),
                              ),
                            ),
                ],
              )
            : const FeedsSkeleton(),
      ),
    );
  }

  List<Widget> listviews() {
    List<Widget> list = [];
    for (int i = 0; i < controller.feedsList.value.length; i++) {
      list.add(_listItemView(controller.feedsList.value[i], i));
    }
    return list;
  }

  Widget _listItemView(Feed feed, int index) {
    return PostsList(
      feed: feed,
    );
  }
}
