import 'package:flutter/material.dart';
import 'package:flutter_project/models/party_participant.dart';
import 'package:flutter_project/modules/parties/widget/parties_card.dart';
import 'package:flutter_project/modules/parties/widget/parties_comment.dart';
import 'package:get/get.dart';

import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/party.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';
import 'package:flutter_project/modules/parties/parties.state.dart';
import 'package:mongo_dart/mongo_dart.dart';

class PartiesController  extends GetxController {
  final PartiesServiceTemplate _partiesService;
  final _partiesStateStream = PartiesState().obs;
  final _partyStateFormStream = PartyFormState().obs;
  final _partyStateStream = PartyState().obs;
  final _partyParticipantsStateStream = PartyParticipantState().obs;

  final User _user = inject<User>();

  List<Widget> get parties => _partiesStateStream.value.parties.map((party) =>
    PartyCard(
      party: party,
      title: party.title,
      date: party.date,
      type: party.type,
      participants: party.partipantsId.length,
      isMine: _user.id == party.userId,
      canOpen: true,
  )).toList();

  PartyFormState get stateForm => _partyStateFormStream.value;

  PartyCard get partyCard => PartyCard(
    title: _partyStateStream.value.party.title,
    date: _partyStateStream.value.party.date,
    type: _partyStateStream.value.party.type,
    participants: _partyStateStream.value.party.partipantsId.length,
    isMine: _user.id == _partyStateStream.value.party.userId,
    canOpen: false,
  );

  ObjectId get partyId => _partyStateStream.value.party.id!;
  Party get party => _partyStateStream.value.party;

  List<Widget> get participantsComments => 
    _partyParticipantsStateStream.value.partyParticipants.map((participant) => 
      PartyComment(
        name: participant.name!,
        comment: participant.comment,
        picture: participant.picture!,
        createdAt: participant.createdAt!,
      )
    ).toList();

  PartiesController(this._partiesService);

  @override
  void onInit() {
    _getParties();
    super.onInit();
  }

  void addParty(Party party) async {
    final mongoParty = await _partiesService.addParty(party);
    _partiesStateStream.value.addParty(mongoParty);
    Get.back();
  }

  void removeParty(Party party) async {
    final res = await _partiesService.deleteParty(party);

    _partiesStateStream.value.deleteParty(party);
  }

  void setPartyDetails(Party party) async {
    _getPartyParticipants(party.id!);
    _partyStateStream.value = PartyState.fill(Party(
      id: party.id,
      userId: party.id,
      partipantsId: party.partipantsId,
      title: party.title,
      date: party.date,
      type: party.type,
      createdAt: party.createdAt,
      status: party.status,
    ));
  }

  void addPartyParticipant(PartyParticipant pp, ObjectId partyId) async {
    final mongoPartyParticipant = await _partiesService.addPartyParticipant(pp, partyId);
    _partyParticipantsStateStream.value.addPartyParticipant(mongoPartyParticipant);
  }

  void _getParties() async {
    final partiesList = await _partiesService.getParties();

    if (partiesList.isEmpty) {
      _partiesStateStream.value = PartiesState();
    } else {
      _partiesStateStream.value = PartiesState.fill(partiesList);
    }
  }

  void _getPartyParticipants(ObjectId partyId) async {
    final partyParticipantList = await _partiesService.getPartyParticipants(partyId);

    if (partyParticipantList.isEmpty) {
      _partyParticipantsStateStream.value = PartyParticipantState();
    } else {
      _partyParticipantsStateStream.value = PartyParticipantState.fill(partyParticipantList);
    }
  }
}