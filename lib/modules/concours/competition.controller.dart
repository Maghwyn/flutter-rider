import 'package:flutter_project/modules/concours/competition.state.dart';
import 'package:get/get.dart';

class ConcoursController  extends GetxController {
  final _concoursStateStream = ConcoursState().obs;

  ConcoursState get state => _concoursStateStream.value;

  void concours(String name, String date_hours, String adress, String picture) async {
    _concoursStateStream.value = ConcoursLoading();

    try{
      _concoursStateStream.value = ConcoursState();
    } on Exception{
      _concoursStateStream.value = ConcoursFailure(error: 'Unknown error occurred.');
    }
  }
}