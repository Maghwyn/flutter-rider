import 'package:flutter/material.dart';
import 'package:flutter_project/modules/courses/courses.controller.dart';
import 'package:flutter_project/modules/courses/courses.form.dart';
import 'package:flutter_project/modules/courses/courses.service.dart';
import 'package:get/get.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    CoursesController cc = Get.put(CoursesController(Get.put(CoursesService())));

    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "• Courses list",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                ),
                ElevatedButton(
                  onPressed: () { Get.to(const CourseForm()); },
                  child: const Text('New Course'),
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
                  children: cc.courses,
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}