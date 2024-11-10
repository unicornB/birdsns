import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';

import '../../models/feed.m.dart';

class FeedHead extends StatelessWidget {
  const FeedHead({super.key, required this.feed});
  final Feed feed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              feed.avatar!.toCircleCachedNetworkImage(
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
                    feed.nickname!,
                    style: TextStyle(
                        fontSize: 32.rpx, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 10.rpx,
                  ),
                  Text(
                    feed.ipCity ?? "",
                    style: TextStyle(
                      color: AppColor.subTitle,
                      fontSize: 24.rpx,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 20.rpx),
          child: const Icon(
            Icons.more_horiz,
            color: AppColor.subTitle,
          ),
        )
      ],
    );
  }
}
