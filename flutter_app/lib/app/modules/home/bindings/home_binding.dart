import 'package:flutter_app/app/modules/home/controllers/image_page_controller.dart';

import '../controllers/home_page_controller.dart';
import '../controllers/mine_controller.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/rec_page_controller.dart';
import '../controllers/circle_page_controller.dart';
import '../controllers/video_page_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<HomePageController>(
      () => HomePageController(),
    );
    Get.lazyPut<RecPageController>(
      () => RecPageController(),
    );
    Get.lazyPut<MineController>(
      () => MineController(),
    );
    Get.lazyPut<CirclePageController>(
      () => CirclePageController(),
    );
    Get.lazyPut<VideoPageController>(
      () => VideoPageController(),
    );
    Get.lazyPut<ImagePageController>(
      () => ImagePageController(),
    );
  }
}
