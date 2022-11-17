import 'package:flutter_project/modules/participant/competition/competition_participant.state.dart';
import 'package:flutter_project/modules/participant/competition/competition_participant.service.dart';
import 'package:get/get.dart';

class ParticipantController  extends GetxController {
  final ParticipantServiceTemplate _participantService = Get.find();
  final _participantStateStream = ParticipantState().obs;

  ParticipantState get state => _participantStateStream.value;

  void participant(String categorie) async {
    final competition = await _participantService.CreateParticipant(categorie);
    _participantStateStream.value = ParticipantLoading();

    try{
      _participantStateStream.value = ParticipantState();
    } on Exception{
      _participantStateStream.value = ParticipantFailure(error: 'Unknown error occurred.');
    }
  }
}