import 'dart:io';

import 'package:flutter/foundation.dart';

import '../core/utils/index.dart' show LogUtil;
import 'app_config.dart';

/// 环境类型
enum ENV {
  DEV,
  TEST,
  PRE,
  PROD,
}

// dio请求前缀
final Map<ENV, String> _baseUrl = {
  ENV.DEV: 'https://sf.shopfly.cn/ZjYGtaulmx.php',
  ENV.TEST: 'https://urltest.com',
  ENV.PRE: 'https://urlpre.com',
  ENV.PROD: 'https://url.com',
};
final Map<ENV, String> _staticBaseUrl = {
  ENV.DEV: 'https://sf.shopfly.cn',
  ENV.TEST: 'https://sf.shopfly.cn',
  ENV.PRE: 'https://sf.shopfly.cn',
  ENV.PROD: 'https://sf.shopfly.cn',
};

class AppEnv {
  /// 当前环境变量
  ENV currentEnv = ENV.DEV;

  /// 安卓渠道名称
  String _androidChannel = '';

  void init() {
    const envStr = String.fromEnvironment("INIT_ENV", defaultValue: "prod");
    if (!kIsWeb && Platform.isAndroid) {
      _androidChannel =
          const String.fromEnvironment("ANDROID_CHANNEL", defaultValue: "");
    }
    switch (envStr) {
      case "dev":
        currentEnv = ENV.DEV;
        break;
      case "test":
        currentEnv = ENV.TEST;
        break;
      case "pre":
        currentEnv = ENV.PRE;
        break;
      case "prod":
        currentEnv = ENV.PROD;
        break;
      default:
        currentEnv = ENV.PROD;
    }
    LogUtil.d('当前环境$currentEnv');
  }

  /// 获取app渠道名称
  String getAppChannel() => _androidChannel;

  /// 设置当前环境
  set setEnv(ENV env) {
    currentEnv = env;
    AppConfig.host = _baseUrl[currentEnv]!;
    AppConfig.staticHost = _staticBaseUrl[currentEnv]!;
  }

  /// 获取url前缀
  String get baseUrl {
    return _baseUrl[currentEnv] ?? '';
  }

  String get staticHost {
    return _staticBaseUrl[currentEnv] ?? '';
  }
}

AppEnv appEnv = AppEnv();
