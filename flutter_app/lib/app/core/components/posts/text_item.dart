import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

import '../../constants/colors/app_color.dart';
import '../../constants/themes/app_styles.dart';
import '../../models/feed.m.dart';
import '../../theme/color_palettes.dart';
import '../custom_icons/app_icon.dart';
import 'foot.dart';
import 'head.dart';

class TextItem extends StatelessWidget {
  const TextItem({
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
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap?.call(feed.id!);
        }
      },
      child: Container(
        color: ColorPalettes.instance.card,
        margin: EdgeInsets.only(top: 10.rpx),
        padding: EdgeInsets.all(20.rpx),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeedHead(
              feed: feed,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            ),
            SizedBox(height: 20.rpx),
            Container(
              padding: EdgeInsets.only(left: 90.rpx),
              child: Text(feed.content!, style: AppStyles.postContentStyle),
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
                      feed.title!,
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
              feed: feed,
              onCollectTap: onCollectTap,
              onCommentTap: onCommentTap,
              onGoodTap: onGoodTap,
              onForwardTap: onForwardTap,
            ),
          ],
        ),
      ),
    );
  }
}
