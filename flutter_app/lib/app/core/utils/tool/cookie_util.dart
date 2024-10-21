import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';

class CookieUtil {
  static PersistCookieJar? _cookieJar;
  /// cookie保存，url 为要储存cookie的某个url
  static Future<void> saveCookie(String url) async {
    Uri uri = Uri.parse(url);
    //获取cookies
    Future<List<Cookie>> cookies =
        (await CookieUtil.cookieJar).loadForRequest(uri);
    cookies.then((value) async {
      /// cookie的储存时存在沙盒路径下
      (await CookieUtil.cookieJar).saveFromResponse(uri, value);
    });
  }
 
  /// cookie获取
  static Future<PersistCookieJar> get cookieJar  async {
    if (_cookieJar == null) {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      _cookieJar = PersistCookieJar(storage: FileStorage(appDocDir.path));
    }
    return _cookieJar!;
  }
 
  /// cookie删除
  static Future<void> delete() async {
    (await CookieUtil.cookieJar).deleteAll();
  }

}