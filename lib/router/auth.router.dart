import 'package:flutter_project/modules/auth/auth.page.dart';
import 'package:flutter_project/modules/placeholder/page.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> authRoutes() => [
  GetPage(
    name: '/home',
    page: () => const PlaceholderPage(),
    middlewares: [MyMiddelware()],
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/auth',
    page: () => const AuthPage(),
    middlewares: [MyMiddelware()],
    transition: Transition.leftToRightWithFade,
    transitionDuration: const Duration(milliseconds: 500),
  ),
];

class MyMiddelware extends GetMiddleware {
  @override
  GetPage? onPageCalled(GetPage? page) {
    print(page?.name);
    return super.onPageCalled(page);
  }
}