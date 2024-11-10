import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/posts_api.dart';
import 'package:flutter_app/app/core/models/banner.m.dart' as model;
import 'package:flutter_app/app/core/models/feed.m.dart';
import 'package:flutter_app/app/core/models/menu.m.dart';
import 'package:get/get.dart';

class RecPageController extends GetxController {
  final count = 0.obs;
  final bannerList = <model.Banner>[].obs;
  final loop = false.obs;
  final menuList = <Menu>[].obs;
  final feedsList = <Feed>[].obs;
  final page = 1.obs;
  final hasMore = true.obs;
  final loading = false.obs;
  final ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
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
  }

  // getData() async {
  //   //refreshController.requestRefresh();
  //   var res = await IndexApi.homeData();
  //   if (res['data']['banners'] != null) {
  //     bannerList.value = (res['data']["banners"] as List)
  //         .map((e) => Banner.fromJson(e))
  //         .toList();
  //     bannerList.refresh();
  //     loop.value = true;
  //   }
  //   if (res['data']['menus'] != null) {
  //     menuList.value =
  //         (res['data']["menus"] as List).map((e) => Menu.fromJson(e)).toList();
  //     menuList.refresh();
  //   }
  // }

  Future<void> getData() async {
    log("数据请求");
    if (!hasMore.value) return;
    log("数据请求1");
    if (loading.value) return;
    log("数据请求2");
    loading.value = true;
    var res = await PostsApi.feedsList(data: {"page": page.value});
    loading.value = false;
    if (res['data']['current_page'] == res['data']['last_page']) {
      hasMore.value = false;
      log("设置为false");
    } else {
      hasMore.value = true;
      page.value++;
      log("设置为true");
    }

    List<Feed> feeds = List<Feed>.from(
        res['data']['data'].map((item) => Feed.fromJson(item)).toList());
    feedsList.value.addAll(feeds);
    feedsList.refresh();
  }

  Future<void> onRefresh() async {
    bannerList.value = [];
    menuList.value = [];
    feedsList.value = [];
    hasMore.value = true;
    page.value = 1;
    await getData();
  }

  Future<void> loadMore() async {
    getData();
  }
}
