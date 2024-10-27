import 'package:flutter_app/app/core/api/index.dart';
import 'package:flutter_app/app/core/models/banner.m.dart';
import 'package:flutter_app/app/core/models/menu.m.dart';
import 'package:get/get.dart';

class RecPageController extends GetxController {
  final count = 0.obs;
  final bannerList = <Banner>[].obs;
  final loop = false.obs;
  final menuList = <Menu>[].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getData() async {
    //refreshController.requestRefresh();
    var res = await IndexApi.homeData();
    if (res['data']['banners'] != null) {
      bannerList.value = (res['data']["banners"] as List)
          .map((e) => Banner.fromJson(e))
          .toList();
      bannerList.refresh();
      loop.value = true;
    }
    if (res['data']['menus'] != null) {
      menuList.value =
          (res['data']["menus"] as List).map((e) => Menu.fromJson(e)).toList();
      menuList.refresh();
    }
  }

  Future<void> onRefresh() async {
    bannerList.value = [];
    menuList.value = [];
    await getData();
  }

  onLoading() async {}

  Future<void> loadMore() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
