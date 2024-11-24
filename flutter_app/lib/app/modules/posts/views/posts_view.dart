import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';
import 'package:flutter_app/app/core/components/comment/comment_item.dart';
import 'package:flutter_app/app/core/components/posts/posts_list.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/comment.m.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../core/components/close_button/close_button.dart';
import '../../../core/components/custom_icons/app_icon.dart';
import '../../../core/utils/tool/app_util.dart';
import '../controllers/posts_controller.dart';

class PostsView extends GetView<PostsController> {
  const PostsView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        backgroundColor: ColorPalettes.instance.background,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          iconTheme: IconThemeData(
            color: ColorPalettes.instance.firstIcon, //修改颜色
          ),
          backgroundColor: ColorPalettes.instance.pure,
          title: Text(
            '帖子',
            style: TextStyle(color: ColorPalettes.instance.firstText),
          ),
          centerTitle: true,
        ),
        body: Obx(() => _buildBody()),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        ListView(
          children: [
            _buildDetail(),
            _commentTitle(),
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
            SizedBox(height: 100.rpx),
          ],
        ),
        Positioned(bottom: 0, left: 0, right: 0, child: _bottomBar()),
      ],
    );
  }

  Widget _buildDetail() {
    return PostsList(
      feed: controller.feed.value,
      onGoodTap: (id) {
        controller.onLike();
      },
      onCollectTap: (id) {
        controller.onCollect();
      },
    );
  }

  Widget _commentTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20.rpx),
      padding: EdgeInsets.symmetric(horizontal: 30.rpx, vertical: 20.rpx),
      color: ColorPalettes.instance.background,
      child: Text(
        '最新评论',
        style: TextStyle(
          color: ColorPalettes.instance.firstText,
          fontSize: 30.rpx,
          fontWeight: FontWeight.bold,
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
      onReplyTap: (comment) {
        controller.hitText.value = "回复 ${comment.nickname}：";
        controller.focusNode.requestFocus();
        controller.pid.value = comment.id!;
        controller.replyIndex.value = index;
      },
      onLikeTap: (comment) {
        controller.onCommentLike(comment.id!, index);
      },
      onMoreTap: (comment) {
        Get.toNamed(Routes.COMMENT, arguments: {"id": comment.id});
      },
    );
  }

  Widget _bottomBar() {
    var isDarkStyle = ColorPalettes.instance.isDark();
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 0.rpx,
      ),
      child: Column(
        children: [
          if (controller.type.value == "image")
            Container(
              alignment: Alignment.centerRight,
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(10.rpx),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(10.rpx)),
                ),
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15.rpx),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.rpx),
                        child: Image.file(
                          File(controller.image.value),
                          width: 100.rpx,
                          height: 100.rpx,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0.rpx,
                      right: 0.rpx,
                      child: CustomCloseButton(
                        color: Colors.red,
                        onPressed: () {
                          controller.type.value = 'text';
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          Container(
            color: ColorPalettes.instance.pure,
            padding: EdgeInsets.only(left: 30.rpx, right: 30.rpx, top: 10.rpx),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: controller.focusNode,
                    controller: controller.contentEditingController,
                    decoration: InputDecoration(
                      hintText: controller.hitText.value,
                      hintStyle: TextStyle(
                        fontSize: 28.rpx,
                        color: ColorPalettes.instance.secondText,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isDarkStyle
                          ? ColorPalettes.instance.background
                          : const Color(0xfff0f0f0),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20.rpx,
                        vertical: 15.rpx,
                      ),
                      isCollapsed: true,
                    ),
                    style: TextStyle(
                      fontSize: 28.rpx,
                      color: ColorPalettes.instance.firstText,
                    ),
                  ),
                ),
                controller.hasFocus.value
                    ? GestureDetector(
                        onTap: () {
                          controller.sendComment();
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 20.rpx),
                          child: Text(
                            "发送",
                            style: TextStyle(
                                fontSize: 28.rpx,
                                color: ColorPalettes.instance.primary),
                          ),
                        ),
                      )
                    : SizedBox(
                        child: _publishButton(),
                      ),
              ],
            ),
          ),
          if (controller.hasFocus.value)
            Container(
              color: ColorPalettes.instance.pure,
              padding: EdgeInsets.symmetric(horizontal: 30.rpx),
              child: _publishButton(showEmoji: true),
            ),
          if (controller.showEmoji.value) _emojiView(),
          if (controller.showRecord.value) _recordView(),
          if (AppUtil.getSafeAreaHeight() > 0)
            Container(
              color: ColorPalettes.instance.pure,
              height: AppUtil.getSafeAreaHeight(),
            ),
        ],
      ),
    );
  }

  Widget _publishButton({bool? showEmoji = false}) {
    Color color = ColorPalettes.instance.primary;

    final double size = 50.rpx;
    return Container(
      decoration: BoxDecoration(
        color: ColorPalettes.instance.pure,
      ),
      child: Row(
        children: [
          IconButton(
            color: color,
            icon: Icon(
              AppIcon.pubImage,
              size: size,
            ),
            onPressed: () {
              controller.selectImage();
            },
          ),
          IconButton(
            color: color,
            icon: Icon(
              AppIcon.pubAudio,
              size: size,
            ),
            onPressed: () {
              controller.showRecord.value = !controller.showRecord.value;
              if (controller.showRecord.value) {
                controller.focusNode.requestFocus();
              } else {
                controller.focusNode.unfocus();
              }
            },
          ),
          if (showEmoji!)
            IconButton(
              color: color,
              icon: Icon(
                AppIcon.pubEmoj,
                size: size,
              ),
              onPressed: () {
                controller.showEmoji.value = !controller.showEmoji.value;
              },
            ),
        ],
      ),
    );
  }

  Widget _emojiView() {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      height: 600.rpx,
      child: EmojiPicker(
        onEmojiSelected: (category, emoji) {},
        onBackspacePressed: () {},
        textEditingController: controller
            .contentEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
        config: Config(
          height: 600.rpx,
          checkPlatformCompatibility: true,
          emojiViewConfig: EmojiViewConfig(
            emojiSizeMax: 28 *
                (foundation.defaultTargetPlatform == TargetPlatform.iOS
                    ? 1.20
                    : 1.0),
          ),
          viewOrderConfig: const ViewOrderConfig(
            top: EmojiPickerItem.searchBar,
            middle: EmojiPickerItem.emojiView,
            bottom: EmojiPickerItem.categoryBar,
          ),
          skinToneConfig: const SkinToneConfig(),
          categoryViewConfig: const CategoryViewConfig(
            backgroundColor: Colors.white,
            dividerColor: Colors.white,
          ),
          bottomActionBarConfig: const BottomActionBarConfig(
            enabled: false,
            backgroundColor: Colors.white,
          ),
          searchViewConfig: const SearchViewConfig(),
        ),
      ),
    );
  }

  Widget _recordView() {
    return Container(
      color: ColorPalettes.instance.pure,
      alignment: Alignment.center,
      height: 460.rpx,
      child: controller.showAudioPlayer.value
          ? SizedBox(
              height: 110.rpx,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  controller.audioPath.value.toLocalAudioPlayer(),
                  IconButton(
                      onPressed: () {
                        controller.showAudioPlayer.value = false;
                        controller.audioPath.value = "";
                        controller.type.value = "text";
                        controller.showRecord.value = false;
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 60.rpx,
                      ))
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${controller.recordTime.value} s",
                  style: TextStyle(
                    fontSize: 30.rpx,
                    color: ColorPalettes.instance.firstText,
                  ),
                ),
                SizedBox(height: 20.rpx),
                GestureDetector(
                  onTap: () {
                    controller.handleRecord();
                  },
                  child: Container(
                    height: 100.rpx,
                    width: 100.rpx,
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(50.rpx),
                    ),
                    child: controller.recording.value
                        ? Icon(
                            AppIcon.microphoneStop,
                            color: Colors.white,
                            size: 40.rpx,
                          )
                        : Icon(
                            AppIcon.microphone,
                            color: Colors.white,
                            size: 50.rpx,
                          ),
                  ),
                )
              ],
            ),
    );
  }
}
