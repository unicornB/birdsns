import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/modules/posts/controllers/comment_controller.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/components/comment/comment_item.dart';
import '../../../core/components/custom_icons/app_icon.dart';
import '../../../core/constants/colors/app_color.dart';
import '../../../core/models/comment.m.dart';

class CommentView extends GetView<CommentController> {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CommentController());
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('更多回复'),
          centerTitle: true,
        ),
        body: Obx(
          () => ListView(
            shrinkWrap: true,
            children: [
              ..._buildCommentList(),
              controller.commentList.value.isEmpty
                  ? TDEmpty(
                      type: TDEmptyType.plain,
                      emptyText: '暂无评论',
                      image: Container(
                        margin: EdgeInsets.only(top: 50.rpx),
                        width: 100,
                        height: 100,
                        child: Icon(
                          AppIcon.empty,
                          size: 100.rpx,
                          color: AppColor.postsSubTitle,
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

  List<Widget> _buildCommentList() {
    List<Widget> list = [];
    for (int i = 0; i < controller.commentList.length; i++) {
      list.add(_commentItem(controller.commentList[i], i));
    }
    return list;
  }

  Widget _commentItem(Comment comment, int index) {
    return CommentItem(
      comment: comment,
      showReply: false,
      showLike: false,
      onLikeTap: (comment) {
        controller.onCommentLike(comment.id!, index);
      },
    );
  }
}
