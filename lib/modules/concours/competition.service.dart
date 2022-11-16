import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ObjectId;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/competition.dart';
import 'package:mongo_dart/src/database/commands/query_and_write_operation_commands/return_classes/write_result.dart';

abstract class CompetitionServiceTemplate extends GetxService {
  Future<Competition> CreateCompetition(String name, String date, String adress, String picture);
}

/// This class simulate the login with hardcoded data.
class CompetitionService extends CompetitionServiceTemplate {
  final DbCollection _competition = inject<DBConnection>().getCollection("competitions");

  @override
  Future<Competition> CreateCompetition(String name, String date, String adress, String picture) async {

    WriteResult mongoDocument = await _competition.insertOne({
      "name": name,
      "date": date,
      "adress": adress,
      "createdAt": DateTime.now(),
      "picture": picture,
      "participant": [""],
    });

    final competition = mongoDocument.document;
    return Competition(
      id: mongoDocument.id as ObjectId,
      name: competition!["name"] as String,
      date: competition["date"] as String,
      adress: competition["adress"] as String,
      createdAt: competition["createdAt"] as DateTime,
      picture: competition["picture"] as String,
      participant: competition["participant"] as List<ObjectId>,
    );
  }
}