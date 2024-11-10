import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/circle.dart';
import 'package:flutter_app/app/core/api/index.dart';
import 'package:flutter_app/app/core/models/circle.m.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:dio/dio.dart' as mdio;

import '../../../core/utils/tool/app_util.dart';

class CircleCreateController extends GetxController {
  //TODO: Implement CircleController

  final count = 0.obs;
  final circleList = <Circle>[].obs;
  final pid = 0.obs;
  final iconimage = "".obs;
  final bannerimage = "".obs;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    getCircleList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void getCircleList() async {
    var res = await IndexApi.getCircleList();
    circleList.value = List<Circle>.from(
        res['data'].map((item) => Circle.fromJson(item)).toList());
    circleList.refresh();
    if (circleList.value.isNotEmpty) {
      pid.value = circleList.value[0].id!;
    }
  }

  Future<void> uploadIconimage(
    AssetEntity entity,
    int type, {
    int? width = 200,
    int? height = 200,
    double? ratioX = 1,
    double? ratioY = 1,
  }) async {
    final file = await entity.file;
    //裁剪
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: file!.path,
      maxWidth: width,
      maxHeight: height,
      aspectRatio: CropAspectRatio(ratioX: ratioX!, ratioY: ratioY!),
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
    var res = await IndexApi.upload(formData);
    AppUtil.hideLoading();
    if (res['code'] == 1) {
      if (type == 1) {
        iconimage.value = res['data']['url'];
      } else {
        bannerimage.value = res['data']['url'];
      }
    }
  }

  void submit() {
    if (pid.value == 0) {
      AppUtil.showToast("circle_select_cate".tr);
      return;
    }
    if (iconimage.value.isEmpty) {
      AppUtil.showToast("circle_input_circle_icon".tr);
      return;
    }
    if (bannerimage.value.isEmpty) {
      AppUtil.showToast("circle_input_circle_banner".tr);
      return;
    }
    if (titleEditingController.text.isEmpty) {
      AppUtil.showToast("circle_input_circle_name".tr);
      return;
    }

    if (descEditingController.text.isEmpty) {
      AppUtil.showToast("circle_input_circle_desc".tr);
      return;
    }
    Object data = {
      "pid": pid.value,
      "iconimage": iconimage.value,
      "bannerimage": bannerimage.value,
      "title": titleEditingController.text,
      "desc": descEditingController.text,
    };
    AppUtil.showLoading("circle_create_ing".tr);
    CircleApi.add(data).then((res) {
      AppUtil.hideLoading();
      AppUtil.showToast(res['msg']);
      if (res['code'] == 1) {
        Get.back();
      }
    });
  }
}
