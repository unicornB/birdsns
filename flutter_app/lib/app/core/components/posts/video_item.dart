import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/play_button/play_button.dart';
import 'package:flutter_app/app/core/components/posts/head.dart';

import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';

import '../../entity/source_entity.dart';
import '../../theme/color_palettes.dart';
import '../../utils/tool/app_util.dart';
import '../custom_icons/app_icon.dart';
import 'foot.dart';

class VideoItem extends StatefulWidget {
  const VideoItem({
    super.key,
    required this.feed,
    this.onTap,
    this.onCommentTap,
    this.onGoodTap,
    this.onCollectTap,
    this.onForwardTap,
    this.onUserTap,
    this.onMoreTap,
  });
  final Feed feed;
  final Function(int id)? onTap;
  final Function(int id)? onCommentTap;
  final Function(int id)? onGoodTap;
  final Function(int id)? onCollectTap;
  final Function(int id)? onForwardTap;
  final Function(int userId)? onUserTap;
  final Function(int id)? onMoreTap;
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!.call(widget.feed.id!);
        }
      },
      child: Container(
        width: 750.rpx,
        padding: EdgeInsets.all(20.rpx),
        margin: EdgeInsets.only(top: 10.rpx),
        color: ColorPalettes.instance.card,
        alignment: Alignment.centerLeft,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedHead(
                feed: widget.feed,
                onUserTap: widget.onUserTap,
                onMoreTap: widget.onMoreTap,
              ),
              SizedBox(height: 20.rpx),
              Container(
                padding: EdgeInsets.only(left: 90.rpx),
                child: Text(
                  widget.feed.content!,
                  style: TextStyle(
                    fontSize: 28.rpx,
                    color: ColorPalettes.instance.firstText,
                  ),
                ),
              ),
              SizedBox(height: 10.rpx),
              GestureDetector(
                onTap: () {
                  List<SourceEntity> sourceEntities = [];
                  sourceEntities.add(SourceEntity(
                      0, "video", AppUtil.getFileUrl(widget.feed.fileUrl!)));
                  AppUtil.openGallery(sourceEntities, 0);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 90.rpx),
                  width: widget.feed.mediaWidth! > widget.feed.mediaHeight!
                      ? 690.rpx
                      : 490.rpx,
                  height: widget.feed.mediaWidth! > widget.feed.mediaHeight!
                      ? 690.rpx *
                          widget.feed.mediaHeight! /
                          widget.feed.mediaWidth! *
                          0.75
                      : 550.rpx,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      widget.feed.fileUrl!.toVideoPoster(
                        width:
                            widget.feed.mediaWidth! > widget.feed.mediaHeight!
                                ? 690.rpx
                                : 490.rpx,
                        radius: 10.rpx,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: PlayButton(),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.rpx),
              Container(
                padding: EdgeInsets.only(left: 90.rpx),
                child: Container(
                  margin: EdgeInsets.only(left: 10.rpx),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 7.rpx),
                  decoration: BoxDecoration(
                    color: ColorPalettes.instance.primary.withAlpha(820),
                    borderRadius: BorderRadius.circular(30.rpx),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        AppIcon.topic,
                        color: ColorPalettes.instance.primary,
                        size: 40.rpx,
                      ),
                      SizedBox(width: 6.rpx),
                      Text(
                        widget.feed.title!,
                        style: TextStyle(
                          fontSize: 26.rpx,
                          color: ColorPalettes.instance.firstText,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.rpx),
              FeedFoot(
                feed: widget.feed,
                onCollectTap: widget.onCollectTap,
                onCommentTap: widget.onCommentTap,
                onGoodTap: widget.onGoodTap,
                onForwardTap: widget.onForwardTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
