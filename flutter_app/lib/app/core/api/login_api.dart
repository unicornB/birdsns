import '../utils/dio/request.dart';

class LoginApi {
  static Future<dynamic> getToken() async {
    return Request.get('/index/getcsfttoken');
  }

  static Future<dynamic> login(String username, String password) async {
    return Request.post('/index/login', data: {
      "username": username,
      "password": password,
    });
  }

  //判断是否登录
  static Future<dynamic> isLogin() async {
    return Request.get('/index/islogin');
  }
}
