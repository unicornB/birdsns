import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/index.dart';
import 'package:flutter_app/app/core/api/posts_api.dart';
import 'package:flutter_app/app/core/models/circle.m.dart';
import 'package:flutter_app/app/core/utils/index.dart';
import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as mdio;
import 'package:path_provider/path_provider.dart';

import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../core/events/events.dart';
import '../../../core/utils/tool/event_util.dart';

class PublishController extends GetxController {
  final count = 0.obs;
  final circle = Circle.fromJson({}).obs;
  final type = "text".obs;
  final images = [].obs;
  final content = "".obs;
  final fileUrl = "".obs;
  final TextEditingController contentEditingController =
      TextEditingController();
  final showRecord = false.obs;
  final recording = false.obs;
  final recordTime = 0.obs;
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  final mRecorderIsInited = false.obs;
  final audioPath = "".obs;
  final showEmoji = false.obs;
  final pollData = [].obs;
  @override
  void onInit() {
    super.onInit();
    EventBusUtil.getInstance().on<PublishSelectCircleEvent>().listen((event) {
      circle.value = event.circle;
    });
    _initRecorder();
    _recordListen();
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

  void selectImage() {
    AppUtil.showActionSheet(
      List<String>.from(["common_camera".tr, "common_album".tr]),
      onSelected: (index) {
        if (index == 0) {
          AppUtil.takePhoto((entity) async {
            mdio.FormData formData = mdio.FormData.fromMap(
                {"file": await AppUtil.multipartFileFromAssetEntity(entity)});
            var res = await IndexApi.upload(formData);
            if (res['code'] == 1) {
              images.value.add(res['data']['url']);
              images.refresh();
            } else {
              AppUtil.showToast(res['msg']);
            }
          });
        } else {
          int count = 9 - images.value.length;
          AppUtil.selectPhotos((files) async {
            AppUtil.showLoading("common_uploading".tr);
            for (AssetEntity file in files) {
              mdio.FormData formData = mdio.FormData.fromMap(
                  {"file": await AppUtil.multipartFileFromAssetEntity(file)});
              var res = await IndexApi.upload(formData);
              if (res['code'] == 1) {
                images.value.add(res['data']['url']);
                images.refresh();
              } else {
                AppUtil.showToast(res['msg']);
              }
            }
            type.value = "image";
            AppUtil.hideLoading();
          }, count: count);
        }
      },
    );
  }

  void selectVideo() {
    AppUtil.showActionSheet(
      List<String>.from(["common_camera".tr, "common_album".tr]),
      onSelected: (index) {
        if (index == 0) {
        } else {
          AppUtil.selectVideo(
            onGet: (entity) async {
              File? file = await entity.file;
              int len = await file!.length();
              if (len > 20 * 1024 * 1024) {
                AppUtil.showToast("文件不能超过20M");
                return;
              }
              AppUtil.showLoading("common_uploading".tr);
              mdio.FormData formData = mdio.FormData.fromMap(
                  {"file": await AppUtil.multipartFileFromAssetEntity(entity)});
              var res = await IndexApi.upload(formData);
              AppUtil.hideLoading();
              if (res['code'] == 1) {
                fileUrl.value = res['data']['url'];
                type.value = "video";
              } else {
                AppUtil.showToast(res['msg']);
              }
            },
          );
        }
      },
    );
  }

  void recordAudio() {
    PermUtil.audioPerm((hasPerm) {
      if (hasPerm) {}
    });
    showRecord.value = !showRecord.value;
  }

  Future<void> _initRecorder() async {
    //开启录音
    await recorderModule.openRecorder();
    //设置订阅计时器
    await recorderModule
        .setSubscriptionDuration(const Duration(milliseconds: 60));
  }

  void handleRecord() {
    if (recording.value) {
      //停止录音
      _stopRecorder();
    } else {
      //开始录音
      PermUtil.audioPerm((hasPerm) async {
        if (hasPerm) {
          //用户允许使用麦克风之后开始录音
          _startRecorder();
        }
      });
    }
  }

  _startRecorder() async {
    Directory tempDir = await getTemporaryDirectory();
    var time = DateTime.now().millisecondsSinceEpoch;
    audioPath.value = '${tempDir.path}/$time${ext[Codec.aacADTS.index]}';
    //这里我录制的是aac格式的，还有其他格式
    await recorderModule.startRecorder(
      toFile: audioPath.value,
      codec: Codec.aacADTS,
      numChannels: 1,
    );
    recording.value = true;
    type.value = "audio";
  }

  _stopRecorder() async {
    await recorderModule.stopRecorder();
    recording.value = false;
    recordTime.value = 0;
    showRecord.value = false;
    //上传文件
    if (audioPath.value.isNotEmpty) {
      AppUtil.showLoading("common_uploading".tr);
      mdio.FormData formData = mdio.FormData.fromMap({
        "file": await AppUtil.multipartFileFromPath(
          audioPath.value,
          contentType: "audio/aac",
        )
      });
      var res = await IndexApi.upload(formData);
      AppUtil.hideLoading();
      if (res['code'] == 1) {
        fileUrl.value = res['data']['url'];
        type.value = "audio";
      } else {
        AppUtil.showToast(res['msg']);
      }
    }
  }

  void _recordListen() async {
    //监听录音
    recorderModule.onProgress!.listen((data) {
      log("录音进度:${data.duration.inSeconds}s");
      recordTime.value = data.duration.inSeconds;
      if (recordTime.value >= 60) {
        _stopRecorder();
      }
    });
  }

  //投票
  void onPollTap() {
    type.value = "poll";
    pollData.value = [
      {"title": ""},
      {"title": ""}
    ];
  }

  Future<void> save() async {
    if (circle.value.id == null) {
      AppUtil.showToast("请选择圈子");
      return;
    }
    if (type.value == "image" && images.value.isEmpty) {
      AppUtil.showToast("请上传图片");
      return;
    }
    if (content.value.isEmpty) {
      AppUtil.showToast("请输入内容");
      return;
    }
    Map<String, dynamic> data = {
      "circle_id": circle.value.id,
      "content": content.value,
      "type": type.value
    };
    if (type.value == "image") {
      data["images"] = images.value.join(",");
    }
    if (type.value == "video" || type.value == "audio") {
      data["file_url"] = fileUrl.value;
    }
    if (type.value == "poll") {
      data["poll_data"] = jsonEncode(pollData.value);
    }
    AppUtil.showLoading("发布中...");
    var res = await PostsApi.publish(data);
    AppUtil.hideLoading();
    AppUtil.showToast(res['msg']);
    if (res['code'] == 1) {
      Get.back();
    }
  }
}
