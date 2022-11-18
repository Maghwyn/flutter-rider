import 'package:flutter/material.dart';
import 'package:flutter_project/modules/admin/admin.controller.dart';
import 'package:flutter_project/modules/admin/admin.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class AdminCourseCard extends StatefulWidget {
  const AdminCourseCard({
    super.key,
    required this.courseId,
    required this.terrain,
    required this.date,
    required this.duration,
    required this.speciality,
    required this.status,
  });

  final mongo.ObjectId courseId;
  final String terrain;
  final DateTime date;
  final String duration;
  final String speciality;
  final String status;

  @override
  State<AdminCourseCard> createState() => _AdminCourseCard();
}

class _AdminCourseCard extends State<AdminCourseCard> {
  @override
  Widget build(BuildContext context) {
    AdminController ac = Get.put(AdminController(Get.put(AdminService())));

    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.deepPurple[50],
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3))),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Wrap(
                    spacing: 20,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.terrain == "Arena"
                              ? "https://ruralbuildermagazine.com/wp-content/uploads/2021/08/LegacySteelBuildingsHeader.jpg"
                              : "https://www.boturfers.fr/themes/boturfer/img/hippodrome-nice.jpg"
                            ),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 10,
                            children: [
                              Text(widget.speciality,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text("- ${widget.duration == "1" ? "1 hour" : "30 minutes"}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text("- ${DateFormat("yyyy-MM-dd").format(widget.date)}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        crossAxisAlignment: WrapCrossAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () { ac.validateCourse(widget.courseId, "accepted"); },
                            child: const Text('Accept'),
                          ),
                          ElevatedButton(
                            onPressed: () { ac.validateCourse(widget.courseId, "rejected"); },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Reject'),
                          ),
                        ],
                      ),
                    ]
                  ),
                ]
              )
            ),
          )
        )
      ),
    );
  }
}