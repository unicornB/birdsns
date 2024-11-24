import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/comment_api.dart';
import 'package:flutter_app/app/core/api/posts_api.dart';
import 'package:flutter_app/app/core/enums/posts_type.dart';
import 'package:flutter_app/app/core/models/feed.m.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart' as mdio;
import '../../../core/api/index.dart';
import '../../../core/models/comment.m.dart';
import '../../../core/utils/index.dart';
import '../../../core/utils/tool/app_util.dart';

class PostsController extends GetxController {
  //TODO: Implement PostsController

  final feed = Feed.fromJson({}).obs;
  final id = 0.obs;
  FocusNode focusNode = FocusNode();
  final TextEditingController contentEditingController =
      TextEditingController();
  final hasFocus = false.obs;
  final showEmoji = false.obs;
  final showImage = true.obs;
  final showRecord = false.obs;
  final recordTime = 0.obs;
  final recording = false.obs;
  FlutterSoundRecorder recorderModule = FlutterSoundRecorder();
  final mRecorderIsInited = false.obs;
  final audioPath = "".obs;
  final type = "text".obs;
  final fileUrl = "".obs;
  final showAudioPlayer = false.obs;
  final image = "".obs;
  final pid = 0.obs;
  final commentList = <Comment>[].obs;
  final hitText = "说点什么吧".obs;
  final ScrollController scrollController = ScrollController();
  final page = 1.obs;
  final hasMore = true.obs;
  final loading = false.obs;
  final replyIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments['id'];
    getData();
    getCommentList();
    focusNode.addListener(() {
      hasFocus.value = focusNode.hasFocus;
      if (!hasFocus.value) {
        if (contentEditingController.text.isEmpty &&
            image.value.isEmpty &&
            audioPath.value.isEmpty) {
          hitText.value = "说点什么吧";
          pid.value = 0;
        }
      }
    });
    _initRecorder();
    _recordListen();
  }

  @override
  void onReady() {
    super.onReady();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("加载更多");
        loadMore();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    recorderModule.closeRecorder();
  }

  Future<void> getData() async {
    var res = await PostsApi.postDetail(id.value);
    if (res['code'] == 1) {
      feed.value = Feed.fromJson(res['data']);
    }
  }

  void loadMore() {
    getCommentList();
  }

  Future<void> onLike() async {
    var res = await PostsApi.postLike(id.value);
    if (res['code'] == 1) {
      feed.value.likeNum = res['data']['num'];
      if (res['data']['type'] == "add") {
        feed.value.liked = true;
        feed.refresh();
      } else {
        feed.value.liked = false;
        feed.refresh();
      }
    }
  }

  Future<void> onCollect() async {
    var res = await PostsApi.postCollect(id.value);
    if (res['code'] == 1) {
      feed.value.collectNum = res['data']['num'];
      if (res['data']['type'] == "add") {
        feed.value.collected = true;
        feed.refresh();
      } else {
        feed.value.collected = false;
        feed.refresh();
      }
    }
  }

  void hideAll() {
    showEmoji.value = false;
    showImage.value = false;
    showRecord.value = false;
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
    showAudioPlayer.value = true;
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

  //上传语音
  void uploadAudio() async {
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

  //上传图片
  void uploadImage() async {
    mdio.FormData formData = mdio.FormData.fromMap(
        {"file": await AppUtil.multipartFileFromPath(image.value)});
    var res = await IndexApi.upload(formData);
  }

  //
  void selectImage() {
    AppUtil.showActionSheet(
      List<String>.from(["common_camera".tr, "common_album".tr]),
      onSelected: (index) {
        if (index == 0) {
          AppUtil.takePhoto((entity) async {
            File? file = await entity.file;
            image.value = file!.path;
            type.value = "image";
          });
        } else {
          AppUtil.selectPhotos((files) async {
            File? file = await files[0].file;
            image.value = file!.path;
            type.value = "image";
          }, count: 1);
        }
      },
    );
  }

  Future<void> sendComment() async {
    if (type.value == PostsType.text.name &&
        contentEditingController.text.isEmpty) {
      AppUtil.showToast("请输入评论内容");
      return;
    }
    if (type.value == PostsType.image.name && image.value.isEmpty) {
      AppUtil.showToast("请上传图片");
      return;
    }
    if (type.value == PostsType.audio.name && audioPath.value.isEmpty) {
      AppUtil.showToast("请上传音频");
      return;
    }
    var data = {
      "content": contentEditingController.text,
      "type": type.value,
      "posts_id": id.value,
      "pid": pid.value,
    };
    AppUtil.showLoading("发送中...");
    if (type.value == PostsType.image.name) {
      mdio.FormData formData = mdio.FormData.fromMap(
          {"file": await AppUtil.multipartFileFromPath(image.value)});
      var res = await IndexApi.upload(formData);
      fileUrl.value = res['data']['url'];
      data['file_url'] = fileUrl.value;
    }
    if (type.value == PostsType.audio.name) {
      if (audioPath.value.isNotEmpty) {
        mdio.FormData formData = mdio.FormData.fromMap({
          "file": await AppUtil.multipartFileFromPath(
            audioPath.value,
            contentType: "audio/aac",
          )
        });
        var res = await IndexApi.upload(formData);
        fileUrl.value = res['data']['url'];
        data['file_url'] = fileUrl.value;
      }
    }
    var res = await CommentApi.add(data);
    AppUtil.hideLoading();
    AppUtil.showToast(res['msg']);
    if (res['code'] == 1) {
      type.value = PostsType.text.name;
      fileUrl.value = "";
      focusNode.unfocus();
      showEmoji.value = false;
      showAudioPlayer.value = false;
      showImage.value = false;
      showRecord.value = false;
      audioPath.value = "";
      image.value = "";
      contentEditingController.clear();
      //构建数据
      if (pid.value > 0) {
        Comment newComment = Comment.fromJson(res['data']);
        newComment.avatar = AppService.to.loginUserInfo.value.avatar!;
        newComment.nickname = AppService.to.loginUserInfo.value.nickname!;
        newComment.likeNum = 0;
        newComment.liked = false;
        if (commentList.value[replyIndex.value].children != null) {
          commentList.value[replyIndex.value].children!.insert(0, newComment);
        } else {
          commentList.value[replyIndex.value].children = [newComment];
        }
      } else {
        Comment newComment = Comment.fromJson(res['data']);
        newComment.avatar = AppService.to.loginUserInfo.value.avatar!;
        newComment.nickname = AppService.to.loginUserInfo.value.nickname!;
        newComment.likeNum = 0;
        newComment.liked = false;
        commentList.insert(0, newComment);
        commentList.refresh();
      }
    }
  }

  void getCommentList() async {
    if (!hasMore.value) return;
    if (loading.value) return;
    loading.value = true;
    var res = await CommentApi.commentlist({"posts_id": id.value});
    loading.value = false;
    if (res['data']['current_page'] == res['data']['last_page']) {
      hasMore.value = false;
    } else {
      hasMore.value = true;
      page.value++;
    }
    commentList.value
        .addAll(List.from(res['data']['data'].map((e) => Comment.fromJson(e))));
    commentList.refresh();
  }

  Future<void> onCommentLike(int commId, int index) async {
    var res = await CommentApi.commentLike(commId);
    if (res['code'] == 1) {
      commentList.value[index].likeNum = res['data']['num'];
      if (res['data']['type'] == "add") {
        commentList.value[index].liked = true;
        commentList.refresh();
      } else {
        commentList.value[index].liked = false;
        commentList.refresh();
      }
    }
  }
}
