import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/api/comment_api.dart';
import '../../../core/models/comment.m.dart';

class CommentController extends GetxController {
  final commentList = <Comment>[].obs;
  final ScrollController scrollController = ScrollController();
  final page = 1.obs;
  final hasMore = true.obs;
  final loading = false.obs;
  final id = 0.obs;
  @override
  void onInit() {
    super.onInit();
    id.value = Get.arguments['id'];
  }

  @override
  void onReady() {
    super.onReady();
    getCommentList();
  }

  void getCommentList() async {
    if (!hasMore.value) return;
    if (loading.value) return;
    loading.value = true;
    var res = await CommentApi.sublist(id.value);
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
