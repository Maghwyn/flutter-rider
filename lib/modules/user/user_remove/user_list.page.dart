import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));

    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  flex: 10,
                  child: Obx(
                        () => ListView(
                      children: uc.usersList,
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}