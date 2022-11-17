import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/layout/app/app.layout.dart';
import 'package:flutter_project/layout/auth/auth.layout.dart';
import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/auth/auth.service.dart';
import 'package:flutter_project/modules/auth/auth.state.dart';
import 'package:flutter_project/modules/loader/page.dart';
import 'package:flutter_project/router/auth.router.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  final mongodb = DBConnection.getInstance();
  await mongodb.connect();

  setupDatabaseLocator(mongodb);
  initializer();

  runApp(const ProjectApp());
}

void initializer() {
  // Injectors
  Get.lazyPut(() => AuthenticationController(Get.put(AuthenticationService())));
}

class ProjectApp extends GetWidget<AuthenticationController> {
  const ProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: authRoutes(),
      title: 'Flutter Obx Auth',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Obx(() {
        if (controller.state is UnAuthenticated) {
          return const AuthLayout();
        }

        if (controller.state is Authenticated) {
          return AppLayout(
            user: (controller.state as Authenticated).user,
          );
        }
        return const SplashScreen();
      }),
    );
  }
}