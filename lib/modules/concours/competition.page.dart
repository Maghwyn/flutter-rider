import 'package:flutter/material.dart';
import 'package:flutter_project/modules/concours/competition.controller.dart';
import 'package:flutter_project/modules/concours/competition.form.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';
import 'package:get/get.dart';

class CompetitionsPage extends StatelessWidget {
  const CompetitionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    CompetitionsController cc = Get.put(CompetitionsController(Get.put(CompetitionsService())));

    return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        "• Competition list",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    ElevatedButton(
                      onPressed: () { Get.to(const CompetitionForm()); },
                      child: const Text('New Competition'),
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
                      children: cc.competitions,
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
}