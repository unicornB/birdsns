import 'package:flutter_app/app/core/api/circle.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';

import '../../../core/models/circle.m.dart';

class CircleController extends GetxController {
  final count = 0.obs;
  final circleList = <Circle>[].obs;
  final selectIndex = 0.obs;
  final from = "".obs; //从哪个页面跳转过来的
  @override
  void onInit() {
    super.onInit();
    from.value = Get.parameters["from"] ?? "";
  }

  @override
  void onReady() {
    super.onReady();
    getCircleList();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void getCircleList() async {
    AppUtil.showLoading("common_loading".tr);
    var res = await CircleApi.getList();
    AppUtil.hideLoading();
    circleList.value = List<Circle>.from(
        res['data'].map((item) => Circle.fromJson(item)).toList());
    circleList.refresh();
  }

  void joinCircle(int circleId) async {
    AppUtil.showLoading("circle_join_ing".tr);
    var res = await CircleApi.follow(circleId);
    AppUtil.showToast(res['msg']);
    AppUtil.hideLoading();
    AppService.to.getMyFollowCircle();
  }

  void cancelCircle(int circleId) async {
    AppUtil.showLoading("circle_canel_ing".tr);
    var res = await CircleApi.followCancel(circleId);
    AppUtil.showToast(res['msg']);
    AppUtil.hideLoading();
    AppService.to.getMyFollowCircle();
  }
}
