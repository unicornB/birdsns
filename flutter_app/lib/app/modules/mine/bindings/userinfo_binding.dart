import 'package:flutter_app/app/modules/mine/controllers/nickname_controller.dart';
import 'package:flutter_app/app/modules/mine/controllers/sign_controller.dart';
import 'package:flutter_app/app/modules/mine/controllers/userinfo_controller.dart';
import 'package:get/get.dart';

class UserinfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserinfoController>(
      () => UserinfoController(),
    );
    Get.lazyPut<NicknameController>(
      () => NicknameController(),
    );
    Get.lazyPut<SignController>(
      () => SignController(),
    );
  }
}
