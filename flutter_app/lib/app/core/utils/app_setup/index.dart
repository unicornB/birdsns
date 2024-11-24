// 初始化第三方插件
import 'package:flutter_app/app/core/utils/size_fit/size_fit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config/app_env.dart';
import '../../theme/color_palettes.dart';
import '../tool/sp_util.dart';
import 'ana_page_loop_init.dart';

Future<void> appSetupInit() async {
  appEnv.init(); // 初始环境
  anaPageLoopInit();
  SpUtil.getInstance(); // 本地缓存初始化
  await ScreenUtil.ensureScreenSize();
  SizeFit.initialize();
  await Get.putAsync(() => SharedPreferences.getInstance());
  ColorPalettes.instance.init();
}
