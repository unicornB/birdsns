import '../utils/dio/request.dart';

class MenuApi {
  /**
   * 权限菜单
   */
  static Future<dynamic> menus() async {
    return Request.get('/api.index/menus');
  }
}
