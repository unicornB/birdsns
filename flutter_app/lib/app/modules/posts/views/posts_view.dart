import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/posts_controller.dart';

class PostsView extends GetView<PostsController> {
  const PostsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PostsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PostsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
