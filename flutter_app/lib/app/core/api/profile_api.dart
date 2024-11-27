import '../utils/dio/request.dart';

class ProfileApi {
  //会员信息
  static Future<dynamic> info(int id) async {
    return Request.post('/api/profile/index', data: {'id': id});
  }

  static Future<dynamic> postsList(Object data) async {
    return Request.post('/api/profile/postslist', data: data);
  }
}
