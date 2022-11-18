import 'package:equatable/equatable.dart';
import 'package:flutter_project/models/party.dart';
import 'package:flutter_project/models/party_participant.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PartiesState {
  late RxList<Party> parties = RxList<Party>();

  PartiesState();
  PartiesState.fill(this.parties);

  addParty(Party party) {
    parties.add(party);
  }

  deleteParty(Party party) {
    parties.remove(party);
  }

  removeById(ObjectId partyId) {
    parties.removeWhere((element) => element.id == partyId);
  }

  List<Party> get props => parties;
}

class PartyState {
  late Party party;
  PartyState();
  PartyState.fill(this.party);
  Party get props => party;
}

class PartyParticipantState{
    late RxList<PartyParticipant> partyParticipants = RxList<PartyParticipant>();

  PartyParticipantState();
  PartyParticipantState.fill(this.partyParticipants);

  addPartyParticipant(PartyParticipant partyParticipant) {
    partyParticipants.add(partyParticipant);
  }

  deletePartyParticipant(PartyParticipant partyParticipant) {
    partyParticipants.remove(partyParticipant);
  }

  List<PartyParticipant> get props => partyParticipants;
}

class PartyFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class PartyFormLoading extends PartyFormState {}

class PartyFormFailure extends PartyFormState {
  final String error;

  PartyFormFailure({required this.error});

  @override
  List<Object> get props => [error];
}