import 'package:flutter/material.dart';
import 'package:flutter_project/models/competition.dart';
import 'package:flutter_project/models/participant_competition.dart';
import 'package:flutter_project/modules/concours/competition.card.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';
import 'package:flutter_project/modules/concours/competition.state.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class CompetitionsController  extends GetxController {
  final CompetitionsService _competitionsService;
  final _competitionsStateStream = CompetitionsState().obs;
  final _competitionsStateFormStream = CompetitionFormState().obs;
  final _competitionParticipantsStateStream = CompetitionParticipantState().obs;

  CompetitionFormState get stateForm => _competitionsStateFormStream.value;

  CompetitionsController(this._competitionsService);

  List<Widget> get competitions => _competitionsStateStream.value.competitions.map((competition) =>
      CompetitionCard(
        name: competition.name,
        date: competition.date,
        adress: competition.adress,
        picture: competition.picture,
      )).toList();

  @override
  void onInit() {
    _getCompetitions();
    super.onInit();
  }

  /*ObjectId get competitionId => _competitionsStateStream.value.competitions.id!;*/

  void addCompetition(Competition competition) async {
    final mongoCompetition = await _competitionsService.addCompetition(competition);
    _competitionsStateStream.value.addCompetition(mongoCompetition);
    Get.back();
  }

  void removeCompetition(Competition competition) async {
    final res = await _competitionsService.deleteCompetition(competition);

    _competitionsStateStream.value.deleteCompetition(competition);
  }

  void addCompetitionParticipant(CompetitionParticipant cp, ObjectId competitionId) async {
    final mongoCompetitionParticipant = await _competitionsService.addCompetitionParticipant(cp, competitionId);
    _competitionParticipantsStateStream.value.addCompetitionParticipant(mongoCompetitionParticipant);
  }

  void _getCompetitionsParticipants(ObjectId competitionId) async {
    final competitionParticipantList = await _competitionsService.getCompetitionParticipants(competitionId);

    if (competitionParticipantList.isEmpty) {
      _competitionParticipantsStateStream.value = CompetitionParticipantState();
    } else {
      _competitionParticipantsStateStream.value = CompetitionParticipantState.fill(competitionParticipantList);
    }
  }

  void _getCompetitions() async {
    final competitionsList = await _competitionsService.getCompetition();

    if (competitionsList.isEmpty) {
      _competitionsStateStream.value = CompetitionsState();
    } else {
      _competitionsStateStream.value = CompetitionsState.fill(competitionsList);
    }
  }
}