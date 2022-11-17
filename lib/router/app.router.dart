import 'package:flutter_project/modules/placeholder/page.dart';
import 'package:get/get.dart';

appRoutes() => [
  GetPage(
    name: '/test',
    page: () => const PlaceholderPage(),
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