import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/config/app_config.dart';
import 'package:flutter_svg/svg.dart';

extension StringExtension on String {
  CachedNetworkImage toCachedNetworkImage(
      {double? width = 50, double? height = 50, BoxFit? fit}) {
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
      fit: fit ?? BoxFit.cover,
    );
  }

  Widget toCircleCachedNetworkImage({
    double? width = 50,
    double? height = 50,
    double? radius = 0,
    BoxFit? fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: toCachedNetworkImage(width: width, height: height, fit: fit),
    );
  }

  Widget toCachedNetworkImageRemote({
    double? width = 50,
    double? height = 50,
    BoxFit? fit = BoxFit.cover,
    double? radius = 0,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: CachedNetworkImage(
        imageUrl: this,
        width: width,
        height: height,
        placeholder: (context, url) => Image.asset(
            "assets/images/default_circle.png",
            width: width,
            height: height),
        // progressIndicatorBuilder: (context, url, progress) =>
        //     Image.asset("assets/images/default_circle.png"),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit,
      ),
    );
  }

  SvgPicture toSvg({double height = 15, double width = 15, Color? color}) =>
      SvgPicture.asset(
        this,
        color: color,
        width: width,
        height: width,
        semanticsLabel: 'A red up arrow',
      );

  Image toAssetImage({double height = 50, double width = 50}) =>
      Image.asset(this, height: height, width: width);
}
