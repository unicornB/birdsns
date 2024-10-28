import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../../config/app_config.dart';

/*
 * Log 拦截器
 */
class LogsInterceptors extends InterceptorsWrapper {
  // 请求拦截
  @override
  onRequest(RequestOptions options, handler) async {
    if (AppConfig.DEBUG) {
      log("请求url：${options.baseUrl + options.path}\n请求类型：${options.method}\n请求头：${options.headers.toString()}");
      // print(
      //     """请求url：${options.baseUrl + options.path}\n请求类型：${options.method}\n请求头：${options.headers.toString()}""");
      if (options.data != null) {
        print('请求参数: ${options.data}');
      }
    }
    return handler.next(options);
  }

  // 响应拦截
  @override
  onResponse(response, handler) async {
    if (AppConfig.DEBUG) {
      log("URL:${response.requestOptions.baseUrl + response.requestOptions.path},参数:${response.requestOptions.queryParameters}");
      log("响应数据：${response.data}");
      if (response.requestOptions.data != null) {
        print('请求参数post: ${response.requestOptions.data}');
      }
      //print('返回参数: $response');
    }

    return handler.next(response);
  }

  // 请求失败拦截
  @override
  onError(DioException err, handler) async {
    if (AppConfig.DEBUG) {
      log(
        '请求异常信息: ${err.response!}',
      );
    }
    if (err.response!.statusCode == 401) {
      log("token失效，请重新登录");
    }
    return handler.next(err);
  }
}
