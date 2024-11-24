import '../utils/dio/request.dart';

class NotificationApi {
  //获取消息数量
  static Future<dynamic> getCount() async {
    return Request.get('/api/notification/getCount');
  }

  static Future<dynamic> getList(int page) async {
    return Request.get('/api/notification/index',
        queryParameters: {"page": page});
  }

  static Future<dynamic> read(int id) async {
    return Request.post('/api/notification/read', data: {'id': id});
  }
}
