import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '/app/core/utils/tool/log_util.dart';
import 'package:get/get.dart';
import 'app/core/components/layouts/basic_layout.dart';
import 'app/core/constants/themes/index_theme.dart';
import 'app/core/utils/app_setup/index.dart';
import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initServices();
  runApp(BasicLayout(
    child: GetMaterialApp(
      title: "Bbs",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: themeLightBlue,
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

  ///这里是你放get_storage、hive、shared_pref初始化的地方。
  ///或者moor连接，或者其他什么异步的东西。
  await appSetupInit();
  await Get.putAsync(() => AppService().init());
  print('All services started...');
}
