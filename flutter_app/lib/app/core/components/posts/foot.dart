import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

import '../../constants/colors/app_color.dart';
import '../../models/feed.m.dart';

class FeedFoot extends StatelessWidget {
  const FeedFoot({
    super.key,
    required this.feed,
    this.onCommentTap,
    this.onGoodTap,
    this.onCollectTap,
    this.onForwardTap,
  });
  final Feed feed;
  final Function(int id)? onCommentTap;
  final Function(int id)? onGoodTap;
  final Function(int id)? onCollectTap;
  final Function(int id)? onForwardTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 110.rpx, right: 20.rpx),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconItem(AppIcon.feedComment, text: "${feed.comNum}", onTap: () {
              onCommentTap?.call(feed.id!);
            }),
            iconItem(
              AppIcon.feedZan,
              text: "${feed.likeNum}",
              onTap: () {
                if (onGoodTap != null) {
                  onGoodTap?.call(feed.id!);
                }
              },
            ),
            iconItem(
              AppIcon.feedCollect,
              onTap: () {
                if (onCollectTap != null) {
                  onCollectTap?.call(feed.id!);
                }
              },
            ),
            iconItem(
              AppIcon.feedForward,
              onTap: () {
                if (onForwardTap != null) {
                  onForwardTap?.call(feed.id!);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget iconItem(IconData icon, {Function()? onTap, String? text}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36.rpx,
            color: AppColor.title,
            weight: 100,
          ),
          SizedBox(width: 6.rpx),
          if (text != null)
            Text(
              text,
              style: TextStyle(color: AppColor.subTitle, fontSize: 28.rpx),
            ),
        ],
      ),
    );
  }
}
