import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MesageController extends GetxController with GetTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;
  var tabIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: tabIndex.value,
    );
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
