import '../utils/dio/request.dart';

class CircleApi {
  //创建圈子
  static Future<dynamic> add(Object data) async {
    return Request.post('/api/circle/add', data: data);
  }

  static Future<dynamic> getList() async {
    return Request.get('/api/circle/index');
  }

  //推荐圈子列表
  static Future<dynamic> getRecList() async {
    return Request.get('/api/circle/reclist');
  }

  //加入圈子
  static Future<dynamic> follow(int circleId) async {
    return Request.post('/api/circle/follow', data: {'circle_id': circleId});
  }

  //取消关注圈子
  static Future<dynamic> followCancel(int circleId) async {
    return Request.post('/api/circle/followcancel',
        data: {'circle_id': circleId});
  }

  //我创建的圈子
  static Future<dynamic> getMyList() async {
    return Request.get('/api/circle/mycirclelist');
  }

  //我关注的圈子
  static Future<dynamic> getFollowList() async {
    return Request.get('/api/circle/myfollows');
  }
}
