import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ObjectId;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/participant_competition.dart';
import 'package:mongo_dart/src/database/commands/query_and_write_operation_commands/return_classes/write_result.dart';

abstract class ParticipantServiceTemplate extends GetxService {
  Future<ParticipantCompetition> CreateParticipant(String categorie);
}

/// This class simulate the login with hardcoded data.
class ParticipantService extends ParticipantServiceTemplate {
  final DbCollection _participant = inject<DBConnection>().getCollection("participants_competition");

  @override
  Future<ParticipantCompetition> CreateParticipant(String categorie) async {

    WriteResult mongoDocument = await _participant.insertOne({
      "user": 1,
      "competition": 1,
      "categorie": categorie,
      "createdAt": DateTime.now(),
    });

    final participant = mongoDocument.document;
    return ParticipantCompetition(
      id: mongoDocument.id as ObjectId,
      user: participant!["user"] as ObjectId,
      competition: participant["competition"] as ObjectId,
      categorie: participant["categorie"] as String,
      createdAt: participant["createdAt"] as DateTime,
    );
  }
}