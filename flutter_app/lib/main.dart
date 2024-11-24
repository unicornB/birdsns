import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '/app/core/utils/tool/log_util.dart';
import 'package:get/get.dart';
import 'app/core/components/layouts/basic_layout.dart';
import 'app/core/constants/themes/index_theme.dart';
import 'app/core/utils/app_setup/index.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  // final themeStr =
  //     await rootBundle.loadString('assets/themes/appainter_theme.json');
  // final themeJson = jsonDecode(themeStr);
  // final theme = ThemeDecoder.decodeThemeData(themeJson);
  runApp(BasicLayout(
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Bbs",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: themeBbsLight,
      darkTheme: themeBbsDark,
      themeMode: ThemeMode.light,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150),
      translationsKeys: AppTranslation.translations,
      locale: const Locale('zh', 'CN'),
      fallbackLocale: const Locale('en', 'US'),
      enableLog: true,
      logWriterCallback: LogUtil.localLogWriter,
      builder: EasyLoading.init(),
    ),
  ));
}

void initServices() async {
  print('starting services ...');
  //判断是安卓还是ios
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 状态栏颜色
        statusBarIconBrightness: Brightness.light, // 状态栏图标颜色
      ),
    );
  }
  TDTheme.needMultiTheme();

  ///这里是你放get_storage、hive、shared_pref初始化的地方。
  ///或者moor连接，或者其他什么异步的东西。
  await appSetupInit();
  await Get.putAsync(() => AppService().init());
  print('All services started...');
  AppService.to.initData();
}
