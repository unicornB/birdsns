import 'dart:developer';

import '../../../config/app_env.dart' show appEnv, ENV;

class LogUtil {
  static d(Object? data) {
    if (appEnv.currentEnv != ENV.PROD) {
      print(data);
    }
  }
  static void localLogWriter(String text, {bool isError = false}) {
    log("日志：$text");
  }
}
