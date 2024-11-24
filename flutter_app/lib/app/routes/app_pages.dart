import 'package:flutter_app/app/modules/posts/views/comment_view.dart';
import 'package:flutter_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:flutter_app/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

import '../core/middleware/auth_middleware.dart';
import '../modules/circle/bindings/circle_binding.dart';
import '../modules/circle/views/circle_create_view.dart';
import '../modules/circle/views/circle_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/mine/bindings/userinfo_binding.dart';
import '../modules/mine/views/nickname_view.dart';
import '../modules/mine/views/sign_view.dart';
import '../modules/mine/views/userinfo_view.dart';
import '../modules/posts/bindings/posts_binding.dart';
import '../modules/posts/views/posts_view.dart';
import '../modules/publish/bindings/publish_binding.dart';
import '../modules/publish/views/publish_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/start/bindings/start_binding.dart';
import '../modules/start/views/start_view.dart';
import '../modules/web/bindings/web_binding.dart';
import '../modules/web/views/web_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PUBLISH,
      page: () => const PublishView(),
      binding: PublishBinding(),
      transition: Transition.downToUp,
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.downToUp,
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
      page: () => const UserinfoView(),
      binding: UserinfoBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.NICKNAME,
      page: () => const NicknameView(),
      binding: UserinfoBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.USERSIGN,
      page: () => const SignView(),
      binding: UserinfoBinding(),
      transition: Transition.rightToLeft,
      middlewares: [
        AuthMiddleware(),
      ],
    ),
    GetPage(
      name: _Paths.CIRCLE,
      page: () => const CircleView(),
      binding: CircleBinding(),
    ),
    GetPage(
      name: _Paths.CIRCLECREATE,
      page: () => const CircleCreateView(),
      binding: CircleBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.POSTS,
      page: () => const PostsView(),
      binding: PostsBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.START,
      page: () => const StartView(),
      binding: StartBinding(),
    ),
    GetPage(
      name: _Paths.COMMENT,
      page: () => const CommentView(),
      binding: StartBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}
