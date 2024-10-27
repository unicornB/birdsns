import 'package:flutter_app/app/core/api/login_api.dart';
import 'package:flutter_app/app/core/api/user_api.dart';
import 'package:flutter_app/app/core/constants/cache_constants.dart';
import 'package:flutter_app/app/core/models/userinfo.m.dart';
import 'package:flutter_app/app/core/utils/index.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';

class AppService extends GetxService {
  final isLogined = false.obs; //是否登录
  final loginToken = ''.obs; //token
  final loginUserInfo = UserInfo().obs; //用户信息
  static AppService to = Get.find<AppService>();
  Future<AppService> init() async {
    return this;
  }

  Future<void> login(String account, String password) async {
    AppUtil.showLoading("login_loading".tr);
    var res = await LoginApi.login(account, password);
    AppUtil.hideLoading();
    AppUtil.showToast(res['msg']);
    if (res['code'] == 1) {
      isLogined.value = true;
      loginUserInfo.value = UserInfo.fromJson(res['data']['userinfo']);
      loginUserInfo.refresh();
      //存储token
      SpUtil.setData(CacheConstants.loginToken, loginUserInfo.value.token);
      loginToken.value = loginUserInfo.value.token!;
      Get.back();
    }
  }

  Future<void> getUserInfo() async {
    var res = await UserApi.userinfo();
    if (res['code'] == 1) {
      loginUserInfo.value = UserInfo.fromJson(res['data']);
      loginUserInfo.refresh();
      isLogined.value = true;
    }
  }
}
