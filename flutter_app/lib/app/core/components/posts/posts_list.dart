import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';
import '../../enums/posts_type.dart';
import 'audio_item.dart';
import 'image_item.dart';
import 'poll_item.dart';
import 'text_item.dart';
import 'video_item.dart';

class PostsList extends StatelessWidget {
  const PostsList(
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (feed.type == PostsType.video.name)
            VideoItem(
              feed: feed,
              onTap: onTap,
              onCommentTap: onCommentTap,
              onCollectTap: onCollectTap,
              onForwardTap: onForwardTap,
              onGoodTap: onGoodTap,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            ),
          if (feed.type == PostsType.audio.name)
            AudioItem(
              feed: feed,
              onTap: onTap,
              onCommentTap: onCommentTap,
              onCollectTap: onCollectTap,
              onForwardTap: onForwardTap,
              onGoodTap: onGoodTap,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            ),
          if (feed.type == PostsType.image.name)
            ImageItem(
              feed: feed,
              onTap: onTap,
              onCommentTap: onCommentTap,
              onCollectTap: onCollectTap,
              onForwardTap: onForwardTap,
              onGoodTap: onGoodTap,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            ),
          if (feed.type == PostsType.text.name)
            TextItem(
              feed: feed,
              onTap: onTap,
              onCommentTap: onCommentTap,
              onCollectTap: onCollectTap,
              onForwardTap: onForwardTap,
              onGoodTap: onGoodTap,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            ),
          if (feed.type == PostsType.poll.name)
            PollItem(
              feed: feed,
              onTap: onTap,
              onCommentTap: onCommentTap,
              onCollectTap: onCollectTap,
              onForwardTap: onForwardTap,
              onGoodTap: onGoodTap,
              onUserTap: onUserTap,
              onMoreTap: onMoreTap,
            )
        ],
      ),
    );
  }
}
