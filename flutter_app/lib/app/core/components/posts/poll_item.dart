import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/posts_api.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';
import 'package:flutter_app/app/core/theme/color_palettes.dart';

import '../../constants/colors/app_color.dart';
import '../custom_icons/app_icon.dart';
import '../polls/polls.dart';
import 'foot.dart';
import 'head.dart';

class PollItem extends StatelessWidget {
  const PollItem(
      {super.key,
      required this.feed,
      this.onTap,
      this.onCommentTap,
      this.onGoodTap,
      this.onCollectTap,
      this.onForwardTap,
      this.onUserTap,
      this.onMoreTap});
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
              child: Polls(
                pollId: feed.id.toString(),
                votesText: "人投票",
                votesTextStyle: TextStyle(
                  color: ColorPalettes.instance.secondText,
                ),
                hasVoted: feed.polled! > 0,
                userVotedOptionId: feed.polled!.toString(),
                pollOptionsFillColor: AppColor.subBg,
                pollOptionsBorder: Border.all(color: AppColor.subBg, width: 1),
                onVoted: (PollOption pollOption, int newTotalVotes) async {
                  var res = await PostsApi.poll({"option_id": pollOption.id});
                  if (res['code'] == 1) {
                    return true;
                  }
                  return false;
                },
                pollEnded: false,
                pollTitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    feed.content!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorPalettes.instance.firstText,
                    ),
                  ),
                ),
                pollOptions: List<PollOption>.from(
                  feed.poll!.map(
                    (option) => PollOption(
                      id: option.id.toString(),
                      title: Text(
                        option.title!,
                        style: TextStyle(
                          fontSize: 28.rpx,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      votes: option.tickets!,
                    ),
                  ),
                ),
                votedPercentageTextStyle: TextStyle(
                  fontSize: 28.rpx,
                  fontWeight: FontWeight.w600,
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
