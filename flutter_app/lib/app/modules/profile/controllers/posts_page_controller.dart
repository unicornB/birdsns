import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/profile_api.dart';
import 'package:get/get.dart';

import '../../../core/models/feed.m.dart';

class PostsPageController extends GetxController {
  final feedsList = <Feed>[].obs;
  final page = 1.obs;
  final hasMore = true.obs;
  final loading = false.obs;
  final ScrollController scrollController = ScrollController();
  final userId = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    log('onInit');
  }

  @override
  void onReady() {
    log('onReady');
    getData();
    super.onReady();
    // TODO: implement onReady
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> getData() async {
    if (!hasMore.value) return;
    if (loading.value) return;
    loading.value = true;
    var res = await ProfileApi.postsList(
        {"page": page.value, "userId": userId.value});
    loading.value = false;
    if (res['data']['current_page'] == res['data']['last_page']) {
      hasMore.value = false;
    } else {
      hasMore.value = true;
      page.value++;
    }

    List<Feed> feeds = List<Feed>.from(
        res['data']['data'].map((item) => Feed.fromJson(item)).toList());
    feedsList.value.addAll(feeds);
    feedsList.refresh();
  }

  Future<void> onRefresh() async {
    feedsList.value = [];
    hasMore.value = true;
    page.value = 1;
    await getData();
  }

  Future<void> loadMore() async {
    getData();
  }
}
