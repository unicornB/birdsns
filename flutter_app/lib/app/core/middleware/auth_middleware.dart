import 'package:flutter/material.dart';
import 'package:flutter_app/app/core/service/app_service.dart';
import 'package:flutter_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (AppService.to.isLogined.value) {
      return null;
    } else {
      return const RouteSettings(name: Routes.LOGIN); // 重定向到登录页面
    }
  }
}
