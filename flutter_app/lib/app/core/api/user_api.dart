import 'package:dio/dio.dart';

import '../utils/dio/request.dart';

class UserApi {
  static Future<dynamic> userinfo() async {
    return Request.get('/api/user/index', queryParameters: {});
  }

  //更新昵称
  static Future<dynamic> updateNickname(Object data) async {
    return Request.post('/api/user/updatenickname', data: data);
  }

  //更新头像
  static Future<dynamic> updateProfile(Object data) async {
    return Request.post('/api/user/profile', data: data);
  }

  static Future<dynamic> uploadAvatar(FormData formData) async {
    return Request.upload('/api/user/updateavatar', formData: formData);
  }
}
