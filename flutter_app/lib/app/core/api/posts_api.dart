import '../utils/dio/request.dart';

class PostsApi {
  static Future<dynamic> publish(Object data) async {
    return Request.post('/api/posts/publish', data: data);
  }

  //帖子列表
  static Future<dynamic> feedsList({Map<String, dynamic>? data}) async {
    return Request.get('/api/posts/index', queryParameters: data);
  }

  //投票
  static Future<dynamic> poll(Object data) async {
    return Request.post('/api/posts/poll', data: data);
  }

  static Future<dynamic> postDetail(int id) async {
    return Request.get('/api/posts/detail', queryParameters: {'id': id});
  }

  static Future<dynamic> postLike(int id) async {
    return Request.post('/api/posts/like', data: {'id': id});
  }

  static Future<dynamic> postCollect(int id) async {
    return Request.post('/api/posts/collect', data: {'id': id});
  }
}
