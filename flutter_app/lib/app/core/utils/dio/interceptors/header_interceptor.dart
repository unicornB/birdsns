import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_app/app/core/api/login_api.dart';
import '../../../../config/app_config.dart';

/*
 * header拦截器
 */
class HeaderInterceptors extends InterceptorsWrapper {
  // 请求拦截
  @override
  onRequest(RequestOptions options, handler) async {
    options.baseUrl = AppConfig.host;
    options.queryParameters['_ajax'] = 1;
    if (options.path != "/index/getcsfttoken") {
      var result = await LoginApi.getToken();
      options.queryParameters['__token__'] = result['data'];
      if (options.data != null) {
        options.data['__token__'] = result['data'];
      }
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
