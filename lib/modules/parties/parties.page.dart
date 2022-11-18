import 'package:flutter/material.dart';
import 'package:flutter_project/modules/parties/widget/parties_form.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PartiesController pc = Get.put(PartiesController(Get.put(PartiesService())));
    UserController uc = Get.put(UserController(Get.put(UserService())));

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => ElevatedButton(
                  onPressed: () => uc.user.role[0] == "USER"
                    ? null
                    : Get.to(const PartyForm()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: uc.user.role[0] == "USER"
                      ? Colors.grey
                      : Colors.purple
                  ),
                  child: const Text('New Party'),
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
                  children: pc.parties,
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}