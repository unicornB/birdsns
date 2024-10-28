import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  //TODO: Implement MineController

  final count = 0.obs;
  ScrollController scrollController = ScrollController();
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {});
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
