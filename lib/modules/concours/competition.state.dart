import 'package:equatable/equatable.dart';
import 'package:flutter_project/models/competition.dart';
import 'package:flutter_project/models/participant_competition.dart';
import 'package:get/get.dart';

class CompetitionsState {
  late RxList<Competition> competitions = RxList<Competition>();

  CompetitionsState();
  CompetitionsState.fill(this.competitions);

  addCompetition(Competition competition) {
    competitions.add(competition);
  }

  deleteCompetition(Competition competition) {
    competitions.remove(competition);
  }

  List<Competition> get props => competitions;
}

class CompetitionFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class CompetitionFormLoading extends CompetitionFormState {}

class CompetitionFormFailure extends CompetitionFormState {
  final String error;

  CompetitionFormFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CompetitionParticipantState{
  late RxList<CompetitionParticipant> competitionParticipants = RxList<CompetitionParticipant>();

  CompetitionParticipantState();
  CompetitionParticipantState.fill(this.competitionParticipants);

  addCompetitionParticipant(CompetitionParticipant competitionParticipant) {
    competitionParticipants.add(competitionParticipant);
  }

  deleteCompetitionParticipant(CompetitionParticipant competitionParticipant) {
    competitionParticipants.remove(competitionParticipant);
  }

  List<CompetitionParticipant> get props => competitionParticipants;
}