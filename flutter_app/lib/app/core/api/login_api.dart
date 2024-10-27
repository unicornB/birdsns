import 'dart:developer';

import '../utils/dio/request.dart';

class LoginApi {
  static Future<dynamic> getToken() async {
    return Request.get('/index/getcsfttoken');
  }

  static Future<dynamic> login(String account, String password) async {
    return Request.post('/api/user/login', data: {
      "account": account,
      "password": password,
    });
  }

  //判断是否登录
  static Future<dynamic> isLogin() async {
    return Request.get('/index/islogin');
  }

  //发送验证码
  static Future<dynamic> sendRegisterCode(String email) async {
    log("邮箱：$email");
    return Request.post('/api/ems/send', data: {
      "email": email,
      "event": "register",
    });
  }

  static Future<dynamic> register(Object data) async {
    return Request.post('/api/user/register', data: data);
  }
}
