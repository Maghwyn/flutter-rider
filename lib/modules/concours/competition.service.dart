import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/competition.dart';
import 'package:flutter_project/models/participant_competition.dart';
import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ObjectId, WriteResult;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class CompetitionServiceTemplate extends GetxService {
  Future<RxList<Competition>> getCompetition();
  Future<Competition> addCompetition(Competition competition);
  Future<bool> deleteCompetition(Competition competition);
  Future<CompetitionParticipant> addCompetitionParticipant(CompetitionParticipant pp, ObjectId competitionId);
  Future<RxList<CompetitionParticipant>> getCompetitionParticipants(ObjectId competitionId);
}

class CompetitionsService extends CompetitionServiceTemplate {
  final DbCollection _competitions = inject<DBConnection>().getCollection("competitions");
  final DbCollection _competitionParticipants = inject<DBConnection>().getCollection("competitionparticipants");

  @override
  Future<CompetitionParticipant> addCompetitionParticipant(CompetitionParticipant cp, ObjectId competitionId) async {
    WriteResult mongoDocument = await _competitionParticipants.insertOne({
      "user": cp.user,
      "competition": competitionId,
      "categorie": cp.categorie,
      "createdAt": DateTime.now(),
    });

    final competitionParticipant = mongoDocument.document;
    return CompetitionParticipant(
      id: mongoDocument.id as ObjectId,
      user: competitionParticipant!["user"] as ObjectId,
      competition: competitionParticipant["competition"] as ObjectId,
      categorie: competitionParticipant["categorie"] as String,
      createdAt: competitionParticipant["createdAt"] as DateTime,
    );
  }

  @override
  Future<RxList<CompetitionParticipant>> getCompetitionParticipants(ObjectId competitionId) async {
    final competitionParticipantsDocuments = await _competitionParticipants.find({
      "competitionId": competitionId,
    }).toList();
    late RxList<CompetitionParticipant> competitionParticipants = RxList<CompetitionParticipant>();

    for(var n = 0; n < competitionParticipantsDocuments.length; n++) {
      var competitionParticipant = competitionParticipantsDocuments[n];

      competitionParticipants.add(CompetitionParticipant(
        id: competitionParticipant["_id"],
        user: competitionParticipant["user"],
        competition: competitionParticipant["competition"],
        categorie: competitionParticipant["categorie"],
        createdAt: competitionParticipant["createdAt"],
      ));
    }

    return competitionParticipants;
  }

  @override
  Future<RxList<Competition>> getCompetition() async {
    final DateTime now = DateTime.now();
    final DateTime week = DateTime(now.year, now.month, now.day + 7);

    final competitionDocuments = await _competitions.find({
      "date": {
        r"$lte": week,
      }
    }).toList();
    late RxList<Competition> competitions = RxList<Competition>();

    for(var n = 0; n < competitionDocuments.length; n++) {
      var competition = competitionDocuments[n];

      competitions.add(Competition(
        id: competition["_id"],
        name: competition["name"],
        date: competition["date"],
        adress: competition["adress"],
        picture: competition["picture"],
        createdAt: competition["createdAt"],
      ));
    }

    return competitions;
  }

  @override
  Future<Competition> addCompetition(Competition competition) async {
    WriteResult mongoDocument = await _competitions.insertOne({
      "name": competition.name,
      "date": competition.date,
      "adress": competition.adress,
      "picture": competition.picture,
      "createdAt": DateTime.now(),
    });

    final mongoCompetition = mongoDocument.document;
    return Competition(
      id: mongoDocument.id as ObjectId,
      name: mongoCompetition?["name"] as String,
      date: mongoCompetition?["date"] as DateTime,
      adress: mongoCompetition?["adress"] as String,
      picture: mongoCompetition?["picture"] as String,
      createdAt: mongoCompetition?["createdAt"] as DateTime,
    );
  }

  @override
  Future<bool> deleteCompetition(Competition competition) async {
    // // TODO: implement deleteCompetition
    // throw UnimplementedError();

    return true;
  }
}