import '../utils/dio/request.dart';

class CommentApi {
  //发布评论
  static Future<dynamic> add(Object data) async {
    return Request.post('/api/comment/add', data: data);
  }

  static Future<dynamic> commentlist(Object data) async {
    return Request.post('/api/comment/index', data: data);
  }

  static Future<dynamic> commentLike(int id) async {
    return Request.post('/api/comment/like', data: {'id': id});
  }

  static Future<dynamic> sublist(int pid) async {
    return Request.post('/api/comment/sublist', data: {'pid': pid});
  }
}
