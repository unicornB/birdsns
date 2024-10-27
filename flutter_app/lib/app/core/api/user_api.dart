import '../utils/dio/request.dart';

class UserApi {
  static Future<dynamic> userinfo() async {
    return Request.get('/api/user/index', queryParameters: {});
  }
}
