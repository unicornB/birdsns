import 'package:dio/dio.dart';

import '../utils/dio/request.dart';

class IndexApi {
  static Future<dynamic> homeData() async {
    return Request.get('/api/index/index', queryParameters: {});
  }

  static Future<dynamic> upload(FormData formData) async {
    return Request.upload('/api/common/upload', formData: formData);
  }

  //圈子列表
  static Future<dynamic> getCircleList({int? pid = 0}) async {
    return Request.get('/api/index/circlelist', queryParameters: {"pid": pid});
  }
}
