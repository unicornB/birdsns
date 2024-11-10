import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/posts/foot.dart';
import 'package:flutter_app/app/core/components/posts/head.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';
import 'package:flutter_app/app/core/extensions/string_extension.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';

import '../../entity/source_entity.dart';
import '../../utils/tool/app_util.dart';
import '../custom_icons/app_icon.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
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
  String getLeftFileCorpUrl(String imageUrl) {
    return "$imageUrl?mode/0/w/350/h/750";
  }

  String getRightFileCorpUrl(String imageUrl) {
    return "$imageUrl?mode/0/w/350/h/200";
  }

  String getOneFileCorpUrl(String imageUrl) {
    return "$imageUrl?mode/0/w/600/h/400";
  }

  String getOtherFileCorpUrl(String imageUrl) {
    return "$imageUrl?mode/0/w/200/h/200";
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
    var images = feed.images!.split(",");
    int len = feed.images!.split(",").length;
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!.call(feed.id!);
        }
      },
      child: Container(
        width: 750.rpx,
        padding: EdgeInsets.all(20.rpx),
        margin: EdgeInsets.only(top: 10.rpx),
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeedHead(feed: feed),
            SizedBox(height: 20.rpx),
            Container(
              padding: EdgeInsets.only(left: 90.rpx),
              child: Text(
                feed.content!,
                style: TextStyle(fontSize: 28.rpx, color: AppColor.title),
              ),
            ),
            SizedBox(height: 10.rpx),
            if (len == 1) _oneImageView(images),
            if (len == 3) _threeImageView(images),
            if (len > 3 || len == 2) _otherImageView(images),
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
                      feed.title!,
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

// 3张图片布局
  Widget _threeImageView(List<String> images) {
    return Container(
      padding: EdgeInsets.only(left: 90.rpx),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.rpx),
              bottomLeft: Radius.circular(20.rpx),
            ),
            child: GestureDetector(
              onTap: () {
                openImages(images, 0);
              },
              child: getLeftFileCorpUrl(images[0])
                  .toCachedNetworkImage(width: 300.rpx, height: 400.rpx),
            ),
          ),
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.rpx),
                ),
                child: GestureDetector(
                  onTap: () {
                    openImages(images, 1);
                  },
                  child: getRightFileCorpUrl(images[1])
                      .toCachedNetworkImage(width: 300.rpx, height: 200.rpx),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20.rpx),
                ),
                child: GestureDetector(
                  onTap: () {
                    openImages(images, 2);
                  },
                  child: getRightFileCorpUrl(images[2])
                      .toCachedNetworkImage(width: 300.rpx, height: 200.rpx),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _oneImageView(List<String> images) {
    return GestureDetector(
      onTap: () {
        openImages(images, 0);
      },
      child: Container(
        padding: EdgeInsets.only(left: 90.rpx),
        child: getOneFileCorpUrl(images[0]).toCircleCachedNetworkImage(
          width: 600.rpx,
          height: 400.rpx,
          radius: 20.rpx,
        ),
      ),
    );
  }

  Widget _otherImageView(List<String> images) {
    List<Widget> list = [];
    for (int i = 0; i < images.length; i++) {
      list.add(_otherImageItem(i, images));
    }
    return Container(
      padding: EdgeInsets.only(left: 90.rpx),
      child: Wrap(
        children: list,
      ),
    );
  }

  Widget _otherImageItem(int index, List<String> images) {
    return Container(
      padding: EdgeInsets.all(10.rpx),
      child: GestureDetector(
        onTap: () {
          openImages(images, index);
        },
        child: getOtherFileCorpUrl(images[index]).toCircleCachedNetworkImage(
            width: 130.rpx, height: 130.rpx, radius: 20.rpx),
      ),
    );
  }
}
