import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/comment.m.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:flutter_app/app/core/utils/tool/date_util.dart';

import '../../entity/source_entity.dart';
import '../../enums/posts_type.dart';

import '../../utils/tool/app_util.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({
    super.key,
    required this.comment,
    this.onReplyTap,
    this.onLikeTap,
    this.onUserTap,
    this.onMoreTap,
    this.showLike = true,
    this.showReply = true,
  });
  final Comment comment;
  final Function(Comment comment)? onReplyTap;
  final Function(Comment comment)? onLikeTap;
  final Function(Comment comment)? onUserTap;
  final Function(Comment comment)? onMoreTap;
  final bool? showLike;
  final bool? showReply;
  String getOneFileCorpUrl(String imageUrl) {
    return "$imageUrl?mode/0/w/300/h/200";
  }

  void openImages(List<String> images, int index) {
    List<SourceEntity> sourceEntities = [];
    for (int i = 0; i < images.length; i++) {
      sourceEntities
          .add(SourceEntity(i, "image", AppUtil.getFileUrl(images[i])));
    }
    AppUtil.openGallery(sourceEntities, index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 20.rpx),
      color: ColorPalettes.instance.background,
      child: Column(
        children: [
          _buildHead(comment),
          _buildContent(comment),
          _buildFootBar(comment),
          if (comment.children != null && comment.children!.isNotEmpty)
            _childrenList(comment),
        ],
      ),
    );
  }

  Widget _buildHead(Comment comment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (onUserTap != null) {
                onUserTap!(comment);
              }
            },
            child: Row(
              children: [
                comment.avatar!.toCircleCachedNetworkImage(
                  width: 80.rpx,
                  height: 80.rpx,
                  radius: 40.rpx,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 10.rpx,
                    ),
                    Text(
                      comment.nickname!,
                      style: TextStyle(
                        fontSize: 32.rpx,
                        color: ColorPalettes.instance.firstText,
                      ),
                    ),
                    SizedBox(
                      width: 10.rpx,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(Comment comment) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 90.rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            comment.content!,
            style: TextStyle(
              fontSize: 28.rpx,
              color: ColorPalettes.instance.secondText,
            ),
          ),
          SizedBox(
            height: 10.rpx,
          ),
          if (comment.type == PostsType.image.name)
            GestureDetector(
              onTap: () {
                openImages([comment.fileUrl!], 0);
              },
              child: getOneFileCorpUrl(comment.fileUrl!)
                  .toCircleCachedNetworkImage(
                width: 300.rpx,
                height: 200.rpx,
                radius: 20.rpx,
              ),
            ),
          if (comment.type == PostsType.audio.name)
            comment.fileUrl!.toAudioPlayer(),
        ],
      ),
    );
  }

  Widget _buildFootBar(Comment comment) {
    return Container(
      margin: EdgeInsets.only(top: 20.rpx),
      padding: EdgeInsets.only(left: 90.rpx, right: 20.rpx),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateUtil.formatTime(comment.createtime!),
                style: TextStyle(
                    color: ColorPalettes.instance.thirdText, fontSize: 24.rpx),
              ),
              Text(
                " · ${comment.country!}·${comment.province!}",
                style: TextStyle(
                    color: ColorPalettes.instance.thirdText, fontSize: 24.rpx),
              ),
              SizedBox(
                width: 20.rpx,
              ),
              if (showLike!)
                GestureDetector(
                  onTap: () {
                    if (onReplyTap != null) {
                      onReplyTap!(comment);
                    }
                  },
                  child: Text(
                    "回复",
                    style: TextStyle(
                        color: ColorPalettes.instance.primary,
                        fontSize: 24.rpx),
                  ),
                )
            ],
          ),
          Container(
            padding: EdgeInsets.only(right: 20.rpx),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (onLikeTap != null) {
                      onLikeTap!(comment);
                    }
                  },
                  child: Icon(
                    AppIcon.feedZan,
                    color: comment.liked != null && comment.liked!
                        ? ColorPalettes.instance.primary
                        : ColorPalettes.instance.thirdIcon,
                    size: 30.rpx,
                  ),
                ),
                if (comment.likeNum! > 0)
                  Text(
                    "${comment.likeNum!}",
                    style: TextStyle(
                        color: comment.liked != null && comment.liked!
                            ? ColorPalettes.instance.primary
                            : ColorPalettes.instance.thirdText,
                        fontSize: 24.rpx),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _childrenList(Comment comment) {
    return Container(
      margin: EdgeInsets.only(top: 20.rpx),
      padding: EdgeInsets.only(
        left: 90.rpx,
        right: 30.rpx,
      ),
      child: Container(
        padding: EdgeInsets.only(
            left: 20.rpx, right: 20.rpx, top: 20.rpx, bottom: 20.rpx),
        decoration: BoxDecoration(
            color: ColorPalettes.instance.thirdText.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10.rpx)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...comment.children!.map((e) => _childrenItem(e)).toList(),
            if (comment.commNum! > 2)
              GestureDetector(
                onTap: () {
                  if (onMoreTap != null) {
                    onMoreTap!(comment);
                  }
                },
                child: Text(
                  "查看${comment.commNum!}条回复",
                  style: TextStyle(
                      color: ColorPalettes.instance.primary, fontSize: 24.rpx),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _childrenItem(Comment comment) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.rpx),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${comment.nickname!}：",
            style: TextStyle(
                color: ColorPalettes.instance.primary, fontSize: 28.rpx),
          ),
          if (comment.type == PostsType.image.name)
            GestureDetector(
              onTap: () {
                openImages([comment.fileUrl!], 0);
              },
              child: Text(
                "[图片] ",
                style: TextStyle(
                    color: ColorPalettes.instance.primary, fontSize: 28.rpx),
              ),
            ),
          if (comment.type == PostsType.audio.name)
            Text("[语音]",
                style: TextStyle(
                    color: ColorPalettes.instance.primary, fontSize: 28.rpx)),
          Expanded(
            child: Text(
              comment.content!,
              softWrap: true,
              style: TextStyle(
                  fontSize: 28.rpx, color: ColorPalettes.instance.firstText),
            ),
          )
        ],
      ),
    );
  }
}
