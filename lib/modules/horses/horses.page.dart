import 'package:flutter/material.dart';
import 'package:flutter_project/modules/horses/horses.controller.dart';
import 'package:flutter_project/modules/horses/horses.service.dart';
import 'package:flutter_project/modules/horses/widget/horses_form.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class HorsesPage extends StatelessWidget {
  const HorsesPage({super.key});

  @override
  Widget build(BuildContext context) {
    HorsesController pc = Get.put(HorsesController(Get.put(HorsesService())));
    UserController uc = Get.put(UserController(Get.put(UserService())));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => ElevatedButton(
                  onPressed: () => uc.user.role[0] != "ADMIN"
                    ? null
                    : Get.to(const HorsesForm()),
                    // : Get.to(const PartyForm()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: uc.user.role[0] != "ADMIN"
                      ? Colors.grey
                      : Colors.purple
                  ),
                  child: const Text('New Horse'),
                )),
              ],
            ),
            Divider(
              height: 20,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.grey[300],
            ),
            Expanded(
              flex: 10,
              child: Obx(
                    () => ListView(
                  children: pc.horses,
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}