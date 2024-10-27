import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/components/color_status_bar/color_status_bar.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_controller.dart';

class WebView extends GetView<WebController> {
  const WebView({super.key});
  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      child: Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(controller.title.value)),
          centerTitle: true,
        ),
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: WebViewWidget(controller: controller.webcontroller),
        ),
      ),
    );
  }
}
