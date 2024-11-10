import '../utils/dio/request.dart';

class PostsApi {
  static Future<dynamic> publish(Object data) async {
    return Request.post('/api/posts/publish', data: data);
  }

  static Future<dynamic> feedsList({Map<String, dynamic>? data}) async {
    return Request.get('/api/posts/index', queryParameters: data);
  }
}
