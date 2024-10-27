import 'dart:developer';

import 'package:flutter_app/app/core/utils/tool/app_util.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController extends GetxController {
  //TODO: Implement WebController
  WebViewController webcontroller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
          log("加载中: $progress");
        },
        onPageStarted: (String url) {
          AppUtil.showLoading("");
        },
        onPageFinished: (String url) {
          AppUtil.hideLoading();
        },
        onHttpError: (HttpResponseError error) {
          AppUtil.hideLoading();
        },
        onWebResourceError: (WebResourceError error) {
          AppUtil.hideLoading();
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
  final count = 0.obs;
  final title = ''.obs;
  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['title'].toString();
    webcontroller.loadRequest(Uri.parse(Get.arguments['url'].toString()));
    log("当前访问：${Get.arguments['url'].toString()}");
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
}
