import 'package:flutter_app/app/modules/profile/controllers/posts_page_controller.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<PostsPageController>(
      () => PostsPageController(),
    );
  }
}
