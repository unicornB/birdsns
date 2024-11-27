import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/circle.dart';

import 'package:flutter_app/app/core/api/login_api.dart';
import 'package:flutter_app/app/core/api/user_api.dart';
import 'package:flutter_app/app/core/constants/cache_constants.dart';
import 'package:flutter_app/app/core/models/userinfo.m.dart';
import 'package:flutter_app/app/core/utils/index.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:dio/dio.dart' as mdio;

import '../api/notification_api.dart';
import '../events/events.dart';
import '../utils/tool/event_util.dart';

class AppService extends GetxService {
  final isLogined = false.obs; //是否登录
  final loginToken = ''.obs; //token
  final loginUserInfo = UserInfo().obs; //用户信息
  final myfollowCircles = [].obs; //我关注的圈子
  final notificationCount = 0.obs; //通知数量
  static AppService to = Get.find<AppService>();
  Future<AppService> init() async {
    return this;
  }

  Future<void> initData() async {
    getUserInfo();
    getMyFollowCircle();
  }

  Future<void> login(String account, String password) async {
    AppUtil.showLoading("login_loading".tr);
    var res = await LoginApi.login(account, password);
    AppUtil.hideLoading();
    AppUtil.showToast(res['msg']);
    if (res['code'] == 1) {
      isLogined.value = true;
      loginUserInfo.value = UserInfo.fromJson(res['data']['userinfo']);
      loginUserInfo.value.avatar =
          AppUtil.getFileUrl(loginUserInfo.value.avatar!);
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
      loginUserInfo.value.avatar =
          AppUtil.getFileUrl(loginUserInfo.value.avatar!);
      loginUserInfo.refresh();
      isLogined.value = true;
    }
  }

  Future<bool> updateNickName(String nickName) async {
    AppUtil.showLoading("user_update_nick_name".tr);
    var res = await UserApi.updateNickname({"nickname": nickName});
    AppUtil.hideLoading();

    if (res['code'] == 1) {
      AppUtil.showToast("user_save_success".tr);
      loginUserInfo.value.nickname = nickName;
      loginUserInfo.refresh();
      return true;
    }
    AppUtil.showToast("user_save_fail".tr);
    return false;
  }

  Future<void> updateAvatar(AssetEntity entity) async {
    final file = await entity.file;
    //裁剪
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      maxWidth: 200,
      maxHeight: 200,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'common_crop'.tr,
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: 'common_crop'.tr,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
    mdio.FormData formData = mdio.FormData.fromMap(
        {"file": await AppUtil.multipartFileFromCroppedFile(croppedFile!)});
    //上传
    AppUtil.showLoading("common_uploading".tr);
    var res = await UserApi.uploadAvatar(formData);
    AppUtil.hideLoading();
    if (res['code'] == 1) {
      getUserInfo();
    }
  }

  Future<bool> updateProfile(Object data) async {
    AppUtil.showLoading("common_updating".tr);
    var res = await UserApi.updateProfile(data);
    AppUtil.hideLoading();
    if (res['code'] == 1) {
      AppUtil.showToast("common_update_success".tr);
      getUserInfo();
      return true;
    }
    AppUtil.showToast("common_update_fail".tr);
    return false;
  }

  //获取我关注的圈子
  Future<void> getMyFollowCircle() async {
    CircleApi.getFollowList().then((res) {
      if (res['data'] != null) {
        myfollowCircles.value = res['data'];
        myfollowCircles.refresh();
      }
    });
  }

  //判断是否关注了某个圈子
  bool isFollowCircle(int circleId) {
    return myfollowCircles.value
        .any((element) => element['circle_id'] == circleId);
  }

  void setNotificationCount(int count) {
    notificationCount.value = count;
    notificationCount.refresh();
  }

  void minusNotificationCount() {
    notificationCount.value = notificationCount.value - 1;
    notificationCount.refresh();
  }

  void getNotificationCount() {
    if (isLogined.value) {
      NotificationApi.getCount().then((res) {
        EventBusUtil.getInstance().fire(NotifiyEvent(res['data']));
        setNotificationCount(res['data']);
      });
    }
  }
}
