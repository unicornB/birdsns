import 'package:flutter_app/app/modules/home/controllers/hot_page_controller.dart';
import 'package:flutter_app/app/modules/home/controllers/image_page_controller.dart';
import 'package:flutter_app/app/modules/home/controllers/messages/notification_controller.dart';
import 'package:flutter_app/app/modules/home/controllers/nearby_page_controller.dart';

import '../controllers/home_page_controller.dart';
import '../controllers/mesage_controller.dart';
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
    Get.lazyPut<NearbyPageController>(
      () => NearbyPageController(),
    );
    Get.lazyPut<HotPageController>(
      () => HotPageController(),
    );
    Get.lazyPut<MesageController>(
      () => MesageController(),
    );
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
