import '../utils/dio/request.dart';

class IndexApi {
  static Future<dynamic> homeData() async {
    return Request.get('/api/index/index', queryParameters: {});
  }
}
