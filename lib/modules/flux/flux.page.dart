import 'package:flutter/material.dart';
import 'package:flutter_project/modules/concours/competition.controller.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';

import 'package:flutter_project/modules/courses/courses.controller.dart';
import 'package:flutter_project/modules/courses/courses.service.dart';
import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';
import 'package:get/get.dart';

class FluxPage extends StatelessWidget {
  const FluxPage({super.key});

  @override
  Widget build(BuildContext context) {
    PartiesController pc =
        Get.put(PartiesController(Get.put(PartiesService())));
    CoursesController cc =
        Get.put(CoursesController(Get.put(CoursesService())));

    CompetitionsController Cc =
        Get.put(CompetitionsController(Get.put(CompetitionsService())));

    return Scaffold(
        body: SafeArea(
            minimum: const EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text("News feed",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.auto_graph_outlined,
                      color: Colors.purple,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Last Parties",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.sports_bar_sharp,
                      color: Colors.purple,
                    ),
                  ],
                ),
                Expanded(
                  flex: 20,
                  child: Obx(
                    () => ListView(
                      children: pc.parties,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Last Courses",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.menu_book_sharp,
                      color: Colors.purple,
                    ),
                  ],
                ),
                Expanded(
                  flex: 20,
                  child: Obx(
                    () => ListView(
                      children: cc.courses,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Last Competition",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.sports_score_sharp,
                      color: Colors.purple,
                    ),
                  ],
                ),
                Expanded(
                  flex: 10,
                  child: Obx(
                    () => ListView(
                      children: Cc.competitions,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Last Riders",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    Icon(
                      Icons.rice_bowl_rounded,
                      color: Colors.purple,
                    ),
                  ],
                ),
              ],
            )));
  }
}
