import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app/config/app_config.dart';
import 'package:flutter_app/app/core/constants/colors/app_color.dart';
import 'package:flutter_app/app/core/constants/fontsize_constants.dart';
import 'package:flutter_app/app/core/extensions/rpx_int_extendsion.dart';

import 'package:flutter_svg/svg.dart';

import '../components/voice_message/voice_controller.dart';
import '../components/voice_message/voice_message_view.dart';

extension StringExtension on String {
  CachedNetworkImage toCachedNetworkImage(
      {double? width = 50, double? height = 50, BoxFit? fit}) {
    log("图片地址：${AppConfig.staticHost + this}");
    String imageUrl = startsWith("http") ? this : AppConfig.staticHost + this;
    return CachedNetworkImage(
      imageUrl: imageUrl,
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
  VoiceMessageView toAudioPlayer() {
    String url = startsWith("http") ? this : AppConfig.staticHost + this;
    return VoiceMessageView(
      controller: VoiceController(
        maxDuration: const Duration(seconds: 10),
        isFile: false,
        audioSrc: url,
        onComplete: () {},
        onPause: () {},
        onPlaying: () {},
        onError: (err) {},
      ),
      backgroundColor: AppColor.primaryColor,
      counterTextStyle: const TextStyle(
          color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
      innerPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      cornerRadius: 20,
      activeSliderColor: Colors.white,
      size: 36,
    );
  }

  Widget toVideoPoster({
    double? width = 50,
    double? height,
    BoxFit? fit,
    double? radius = 0,
    Function(ImageInfo info)? onLoaded,
  }) {
    String imageUrl = startsWith("http") ? this : AppConfig.staticHost + this;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: CachedNetworkImage(
        imageUrl: "$imageUrl.jpg",
        width: width,
        height: height,
        placeholder: (context, url) => Image.asset(
          "assets/images/default_circle.png",
          height: 200.rpx,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        fit: fit ?? BoxFit.cover,
      ),
    );
  }

  VoiceMessageView toLocalAudioPlayer() {
    return VoiceMessageView(
      controller: VoiceController(
        maxDuration: const Duration(seconds: 10),
        isFile: true,
        audioSrc: this,
        onComplete: () {},
        onPause: () {},
        onPlaying: () {},
        onError: (err) {},
      ),
      backgroundColor: AppColor.primaryColor,
      counterTextStyle: const TextStyle(
          color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500),
      innerPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      cornerRadius: 20,
      activeSliderColor: Colors.white,
      size: 36,
    );
  }
}
