import 'package:flutter_project/modules/concours/competition.state.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';
import 'package:get/get.dart';

class CompetitionController  extends GetxController {
  final CompetitionServiceTemplate _competitionService = Get.find();
  final _competitionStateStream = ConcoursState().obs;

  ConcoursState get state => _competitionStateStream.value;

  void concours(String name, String date_hours, String adress, String picture) async {
    final competition = await _competitionService.CreateCompetition(name, date_hours, adress, picture);
    _competitionStateStream.value = ConcoursLoading();

    try{
      _competitionStateStream.value = ConcoursState();
    } on Exception{
      _competitionStateStream.value = ConcoursFailure(error: 'Unknown error occurred.');
    }
  }
}