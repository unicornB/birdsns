import 'package:get/get.dart';

import '../controllers/circle_controller.dart';
import '../controllers/circle_create_controller.dart';

class CircleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CircleController>(
      () => CircleController(),
    );
    Get.lazyPut<CircleCreateController>(
      () => CircleCreateController(),
    );
  }
}
