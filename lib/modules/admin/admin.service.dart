
import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ModifierBuilder, ObjectId, where;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/models/party.dart';

abstract class AdminServiceTemplate extends GetxService {
  Future<RxList<Course>> getCourses();
  Future<RxList<Party>> getParties();
  Future<bool> updateCourseStatus(ObjectId courseId, String status);
  Future<bool> updatePartyStatus(ObjectId partyId, String status);
}

class AdminService extends AdminServiceTemplate {
  final DbCollection _parties = inject<DBConnection>().getCollection("parties");
  final DbCollection _courses = inject<DBConnection>().getCollection("courses");
  
  @override
  Future<RxList<Course>> getCourses() async {
    final coursesDocuments = await _courses.find({
      "status": "pending",
    }).toList();

    late RxList<Course> courses = RxList<Course>();

    for(var n = 0; n < coursesDocuments.length; n++) {
      var course = coursesDocuments[n];

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
  Future<RxList<Party>> getParties() async {
    final partiesDocuments = await _parties.find({
      "status": "pending",
    }).toList();

    late RxList<Party> parties = RxList<Party>();

    for(var n = 0; n < partiesDocuments.length; n++) {
      var party = partiesDocuments[n];

      parties.add(Party(
        id: party["_id"],
        userId: party["userId"],
        partipantsId: party["participantsId"],
        title: party["title"],
        date: party["date"],
        createdAt: party["createdAt"],
        type: party["type"],
        status: party["status"],
      ));
    }

    return parties;
  }
  
  @override
  Future<bool> updateCourseStatus(ObjectId courseId, String status) async {
    await _courses.updateOne(
      where.eq("_id", courseId),
      ModifierBuilder()
        .set("status", status)
    );

    return true;
  }
  
  @override
  Future<bool> updatePartyStatus(ObjectId partyId, String status) async {
    await _parties.updateOne(
      where.eq("_id", partyId),
      ModifierBuilder()
        .set("status", status)
    );

    return true;
  }
}