import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/custom_icons/app_icon.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';
import 'package:flutter_app/app/core/utils/tool/date_util.dart';

import '../../models/feed.m.dart';

class FeedHead extends StatelessWidget {
  const FeedHead(
      {super.key, required this.feed, this.onUserTap, this.onMoreTap});
  final Feed feed;
  final Function(int userId)? onUserTap;
  final Function(int id)? onMoreTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              if (onUserTap != null) {
                onUserTap!(feed.userId!);
              }
            },
            child: Row(
              children: [
                feed.avatar!.toCircleCachedNetworkImage(
                  width: 80.rpx,
                  height: 80.rpx,
                  radius: 40.rpx,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10.rpx,
                        ),
                        Text(
                          feed.nickname!,
                          style: TextStyle(
                            fontSize: 32.rpx,
                            color: ColorPalettes.instance.firstText,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10.rpx,
                        ),
                        Text(
                          "${DateUtil.formatTime(feed.createtime!)} · ${feed.ipCity!}",
                          style: TextStyle(
                              color: ColorPalettes.instance.secondText,
                              fontSize: 24.rpx),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (onMoreTap != null) {
              onMoreTap!(feed.id!);
            }
          },
          child: Container(
            padding: EdgeInsets.only(right: 20.rpx),
            child: const Icon(
              Icons.more_horiz,
              color: AppColor.subTitle,
            ),
          ),
        )
      ],
    );
  }
}
