import 'package:flutter_app/app/modules/mine/controllers/userinfo_controller.dart';
import 'package:get/get.dart';

class UserinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserinfoController>(
      () => UserinfoController(),
    );
  }
}
