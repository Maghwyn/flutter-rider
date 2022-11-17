import 'package:flutter/material.dart';
import 'package:flutter_project/modules/party/widget/parties_form.dart';
import 'package:get/get.dart';

import 'package:flutter_project/modules/party/parties.controller.dart';
import 'package:flutter_project/modules/party/parties.service.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    PartiesController pc = Get.put(PartiesController(Get.put(PartiesService())));

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "• Parties list",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
                ElevatedButton(
                  onPressed: () { Get.to(const PartyForm()); },
                  child: const Text('New Party'),
                ),
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