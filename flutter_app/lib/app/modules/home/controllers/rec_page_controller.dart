import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/notification_api.dart';
import 'package:flutter_app/app/core/api/posts_api.dart';
import 'package:flutter_app/app/core/models/banner.m.dart' as model;
import 'package:flutter_app/app/core/models/feed.m.dart';
import 'package:flutter_app/app/core/models/menu.m.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/core/utils/tool/event_util.dart';
import 'package:get/get.dart';

import '../../../core/events/events.dart';

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
  late final AppLifecycleListener lifecycleListener;
  late Timer timer;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
    getCount();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        log("加载更多");
        loadMore();
      }
    });
    log("生命周期");
    timer = Timer.periodic(const Duration(seconds: 60), timerCallback);
    lifecycleListener = AppLifecycleListener(
      onStateChange: (value) {
        log("生命周期$value");
      },
      onResume: () {
        timer = Timer.periodic(const Duration(seconds: 60), timerCallback);
      },
      onPause: () {
        timer.cancel();
      },
    );
  }

  @override
  void onClose() {
    super.onClose();
    lifecycleListener.dispose();
    timer.cancel();
  }

  void timerCallback(Timer timer) {
    log("生命定时器");
    getCount();
  }

  void getCount() {
    AppService.to.getNotificationCount();
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

  Future<void> onLike(int id, int index) async {
    var res = await PostsApi.postLike(id);
    if (res['code'] == 1) {
      feedsList.value[index].likeNum = res['data']['num'];
      if (res['data']['type'] == "add") {
        feedsList.value[index].liked = true;
      } else {
        feedsList.value[index].liked = false;
      }
      feedsList.refresh();
    }
  }

  Future<void> onCollect(int id, int index) async {
    var res = await PostsApi.postCollect(id);
    if (res['code'] == 1) {
      feedsList.value[index].collectNum = res['data']['num'];
      if (res['data']['type'] == "add") {
        feedsList.value[index].collected = true;
      } else {
        feedsList.value[index].collected = false;
      }
      feedsList.refresh();
    }
  }
}
