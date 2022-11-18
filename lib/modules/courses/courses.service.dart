import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ObjectId, WriteResult;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class CoursesServiceTemplate extends GetxService {
  Future<RxList<Course>> getCourses();
  Future<Course> addCourse(Course course);
  Future<bool> deleteCourse(Course course);
}

class CoursesService extends CoursesServiceTemplate {
  final DbCollection _courses = inject<DBConnection>().getCollection("courses");
  final User _user = inject<User>();

  @override
  Future<RxList<Course>> getCourses() async {
    final DateTime now = DateTime.now();
    final DateTime week = DateTime(now.year, now.month, now.day + 7);

    final courseDocuments = await _courses.find({
      "date": {
        r"$lte": week,
      }
    }).toList();
    late RxList<Course> courses = RxList<Course>();

    for(var n = 0; n < courseDocuments.length; n++) {
      var course = courseDocuments[n];

      courses.add(Course(
        id: course["_id"],
        userId: course["userId"],
        terrain: course["terrain"],
        date: course["date"],
        createdAt: course["createdAt"],
        duration: course["duration"],
        speciality: course["speciality"],
        status: course["status"],
      ));
    }

    return courses;
  }

  @override
  Future<Course> addCourse(Course course) async {
    WriteResult mongoDocument = await _courses.insertOne({
      "userId": _user.id,
      "terrain": course.terrain,
      "date": course.date,
      "createdAt": DateTime.now(),
      "duration": course.duration,
      "speciality": course.speciality,
      "status": course.status,
    });

    final mongoCourse = mongoDocument.document;
    return Course(
      id: mongoDocument.id as ObjectId,
      userId: mongoCourse!["userId"] as ObjectId,
      terrain: mongoCourse["terrain"] as String,
      date: mongoCourse["date"] as DateTime,
      createdAt: mongoCourse["createdAt"] as DateTime,
      duration: mongoCourse["duration"] as String,
      speciality: mongoCourse["speciality"] as String,
      status: mongoCourse["status"] as String,
    );
  }

  @override
  Future<bool> deleteCourse(Course course) async {
    // // TODO: implement deleteCourse
    // throw UnimplementedError();

    return true;
  }
}