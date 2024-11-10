import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/posts/head.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';

import '../../constants/colors/app_color.dart';
import '../../entity/source_entity.dart';
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
  });
  final Feed feed;
  final Function(int id)? onTap;
  final Function(int id)? onCommentTap;
  final Function(int id)? onGoodTap;
  final Function(int id)? onCollectTap;
  final Function(int id)? onForwardTap;
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
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Container(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeedHead(feed: widget.feed),
              SizedBox(height: 20.rpx),
              Container(
                padding: EdgeInsets.only(left: 90.rpx),
                child: Text(widget.feed.content!),
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
                      Align(
                        alignment: Alignment.center,
                        child: Icon(
                          AppIcon.play,
                          size: 80.rpx,
                          color: Colors.white,
                        ),
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
                    color: AppColor.primaryColor.withAlpha(820),
                    borderRadius: BorderRadius.circular(30.rpx),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        AppIcon.topic,
                        color: AppColor.primaryColor,
                        size: 40.rpx,
                      ),
                      SizedBox(width: 6.rpx),
                      Text(
                        widget.feed.title!,
                        style: TextStyle(
                          fontSize: 26.rpx,
                          color: AppColor.title,
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
