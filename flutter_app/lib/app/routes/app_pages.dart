import 'package:flutter_app/app/core/middleware/auth_middleware.dart';
import 'package:flutter_app/app/modules/mine/bindings/userinfo_binding.dart';
import 'package:flutter_app/app/modules/mine/views/userinfo_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/publish/bindings/publish_binding.dart';
import '../modules/publish/views/publish_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/web/bindings/web_binding.dart';
import '../modules/web/views/web_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PUBLISH,
      page: () => const PublishView(),
      binding: PublishBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WEB,
      page: () => const WebView(),
      binding: WebBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.USERINFO,
      page: () => UserinfoView(),
      binding: UserinfoBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
    ),
  ];
}
