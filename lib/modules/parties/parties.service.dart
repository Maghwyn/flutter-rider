import 'dart:ui';

import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/party.dart';
import 'package:flutter_project/models/party_participant.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ObjectId, WriteResult;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class PartiesServiceTemplate extends GetxService {
  Future<RxList<Party>> getParties();
  Future<RxList<PartyParticipant>> getPartyParticipants(ObjectId partyId);
  Future<Party> addParty(Party party);
  Future<PartyParticipant> addPartyParticipant(PartyParticipant pp, ObjectId partyId);
  Future<bool> deleteParty(Party party);
}

class PartiesService extends PartiesServiceTemplate {
  final DbCollection _parties = inject<DBConnection>().getCollection("parties");
  final DbCollection _partyParticipants = inject<DBConnection>().getCollection("partyparticipants");
  final User _user = inject<User>();

  @override
  Future<RxList<Party>> getParties() async {
    final DateTime now = DateTime.now();
    final DateTime week = DateTime(now.year, now.month, now.day + 7);

    final partiesDocuments = await _parties.find(/*{
      "date": {
        r"$lte": week,
      }
    }*/).toList();
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
  Future<RxList<PartyParticipant>> getPartyParticipants(ObjectId partyId) async {
    final partyParticipantsDocuments = await _partyParticipants.find({
      "partyId": partyId,
    }).toList();
    late RxList<PartyParticipant> partyParticipants = RxList<PartyParticipant>();

    for(var n = 0; n < partyParticipantsDocuments.length; n++) {
      var partyParticipant = partyParticipantsDocuments[n];

      partyParticipants.add(PartyParticipant(
        id: partyParticipant["_id"],
        userId: partyParticipant["userId"],
        partyId: partyParticipant["partyId"],
        name: partyParticipant["name"],
        comment: partyParticipant["comment"],
        createdAt: partyParticipant["createdAt"],
        picture: partyParticipant["picture"],
      ));
    }

    return partyParticipants;
  }

  @override
  Future<Party> addParty(Party party) async {
    WriteResult mongoDocument = await _parties.insertOne({
      "userId": _user.id,
      "participantsId": [],
      "title": party.title,
      "date": party.date,
      "createdAt": DateTime.now(),
      "type": party.type,
      "status": party.status,
    });

    final mongoParty = mongoDocument.document;
    return Party(
      id: mongoDocument.id as ObjectId,
      userId: mongoParty!["userId"] as ObjectId,
      partipantsId: [],
      title: mongoParty["title"] as String,
      date: mongoParty["date"] as DateTime,
      createdAt: mongoParty["createdAt"] as DateTime,
      type: mongoParty["type"] as String,
      status: mongoParty["status"] as String,
    );
  }

  @override
  Future<bool> deleteParty(Party party) async {
    // // TODO: implement deleteCourse
    // throw UnimplementedError();
    return true;
  }


  @override
  Future<PartyParticipant> addPartyParticipant(PartyParticipant pp, ObjectId partyId) async {
    WriteResult mongoDocument = await _partyParticipants.insertOne({
      "userId": _user.id,
      "partyId": partyId,
      "name": _user.name,
      "comment": pp.comment,
      "createdAt": DateTime.now(),
      "picture": _user.picture,
    });

    final partyParticipant = mongoDocument.document;
    return PartyParticipant(
      id: mongoDocument.id as ObjectId,
      userId: partyParticipant!["userId"] as ObjectId,
      partyId: partyParticipant["partyId"] as ObjectId,
      name: partyParticipant["name"] as String,
      comment: partyParticipant["comment"] as String,
      createdAt: partyParticipant["createdAt"] as DateTime,
      picture: partyParticipant["picture"] as String,
    );
  }
}