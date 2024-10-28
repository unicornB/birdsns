import 'dart:developer';

import 'package:dio/dio.dart';

import 'package:flutter_app/app/core/constants/cache_constants.dart';
import 'package:flutter_app/app/core/utils/index.dart';

/*
 * header拦截器
 */
class HeaderInterceptors extends InterceptorsWrapper {
  // 请求拦截
  @override
  onRequest(RequestOptions options, handler) async {
    String token =
        await SpUtil.getData<String>(CacheConstants.loginToken, defValue: "");
    log("token: $token");
    if (token.isNotEmpty) {
      options.headers['token'] = token;
    }
    return handler.next(options);
  }

  // 响应拦截
  @override
  onResponse(response, handler) {
    // Do something with response data
    return handler.next(response); // continue
  }

  // 请求失败拦截
  @override
  onError(err, handler) async {
    return handler.next(err); //continue
  }
}
