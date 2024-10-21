import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/config/app_config.dart';

extension StringExtension on String {
  CachedNetworkImage toCachedNetworkImage(
      {double? width = 50, double? height = 50}) {
    log("图片地址：${AppConfig.staticHost + this}");
    return CachedNetworkImage(
      imageUrl: AppConfig.staticHost + this,
      width: width,
      height: height,
      placeholder: (context, url) =>
          Image.asset("assets/images/default_circle.png"),
      // progressIndicatorBuilder: (context, url, progress) =>
      //     Image.asset("assets/images/default_circle.png"),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget toCircleCachedNetworkImage(
      {double? width = 50, double? height = 50, double? radius = 0}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: toCachedNetworkImage(width: width, height: height),
    );
  }
}
