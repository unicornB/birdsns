import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/api/notification_api.dart';
import 'package:flutter_app/app/core/events/events.dart';
import 'package:flutter_app/app/core/models/notification.m.dart';
import 'package:flutter_app/app/core/utils/tool/event_util.dart';
import 'package:get/get.dart';

import '../../../../core/service/app_service.dart';
import '../../../../routes/app_pages.dart';

class NotificationController extends GetxController {
  final notificationList = [].obs;
  final page = 1.obs;
  final hasMore = true.obs;
  final loading = false.obs;
  final ScrollController scrollController = ScrollController();
  final total = 0.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    EventBusUtil.getInstance().on<NotifiyEvent>().listen((event) {
      int count = event.count;
      // if (count > total.value) {
      //   onRefresh();
      // }
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getData();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void onRefresh() {
    page.value = 1;
    hasMore.value = true;
    loading.value = false;
    notificationList.value.clear();
    getData();
    AppService.to.getNotificationCount();
  }

  Future<void> getData() async {
    if (!hasMore.value) return;
    if (loading.value) return;
    loading.value = true;
    var res = await NotificationApi.getList(page.value);
    loading.value = false;
    total.value = res['data']['total'];
    if (res['data']['current_page'] == res['data']['last_page']) {
      hasMore.value = false;
    } else {
      hasMore.value = true;
      page.value++;
    }

    List<Notifications> feeds = List<Notifications>.from(res['data']['data']
        .map((item) => Notifications.fromJson(item))
        .toList());
    notificationList.value.addAll(feeds);
    notificationList.refresh();
  }

  void toDetail(Notifications notification, int index) {
    NotificationApi.read(notification.id!);
    if (notification.status == "0") {
      AppService.to.minusNotificationCount();
      notificationList.value[index].status = "1";
      notificationList.refresh();
    }
    Get.toNamed(Routes.POSTS, arguments: {"id": notification.entryId});
  }
}
