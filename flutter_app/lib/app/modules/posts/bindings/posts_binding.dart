import 'package:flutter_app/app/modules/posts/controllers/comment_controller.dart';
import 'package:get/get.dart';

import '../controllers/posts_controller.dart';

class PostsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostsController>(
      () => PostsController(),
    );
    Get.lazyPut<CommentController>(
      () => CommentController(),
    );
  }
}
