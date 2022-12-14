import 'package:flutter/material.dart';
import 'package:flutter_project/modules/courses/courses.controller.dart';
import 'package:flutter_project/modules/courses/courses.state.dart';
import 'package:flutter_project/modules/courses/widget/courses_form.dart';
import 'package:flutter_project/modules/courses/courses.service.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CoursesController cc = Get.put(CoursesController(Get.put(CoursesService())));
    UserController uc = Get.put(UserController(Get.put(UserService())));

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 225,
                  child: Obx(() => SwitchListTile(
                    value: cc.stateToggle is CourseShowFinished,
                    title: const Text("Show finished", style: TextStyle(fontWeight: FontWeight.bold)),
                    onChanged: (bool value) => cc.toggleVisibility(value),
                  )),
                ),
                Obx(() => ElevatedButton(
                  onPressed: () => uc.user.role[0] == "USER"
                    ? null
                    : Get.to(const CourseForm()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: uc.user.role[0] == "USER"
                      ? Colors.grey
                      : Colors.purple
                  ),
                  child: const Text('New Course'),
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
            Flexible(
              child: Obx(() => GridView.count(
                primary: false,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: cc.courses,
              )),
            )
          ],
        )
      )
    );
  }
}