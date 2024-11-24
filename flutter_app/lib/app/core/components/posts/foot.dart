import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
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
              active: feed.liked != null ? feed.liked! : false,
              onTap: () {
                if (onGoodTap != null) {
                  onGoodTap?.call(feed.id!);
                }
              },
            ),
            iconItem(
              AppIcon.feedCollect,
              active: feed.collected != null ? feed.collected! : false,
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

  Widget iconItem(IconData icon,
      {Function()? onTap, String? text, bool? active = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 36.rpx,
            color: active!
                ? ColorPalettes.instance.primary
                : ColorPalettes.instance.secondIcon,
            weight: 100,
          ),
          SizedBox(width: 6.rpx),
          if (text != null)
            Text(
              text,
              style: TextStyle(
                  color: active
                      ? ColorPalettes.instance.primary
                      : ColorPalettes.instance.secondText,
                  fontSize: 28.rpx),
            ),
        ],
      ),
    );
  }
}
