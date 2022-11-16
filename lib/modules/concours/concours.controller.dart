import 'package:flutter_project/modules/concours/concours.state.dart';
import 'package:get/get.dart';

class ConcoursController  extends GetxController {
  final _concoursStateStream = ConcoursState().obs;

  ConcoursState get state => _concoursStateStream.value;

  void concours(String training, String date_hours, String duration, String speciality) async {
    _concoursStateStream.value = ConcoursLoading();

    try{
      _concoursStateStream.value = ConcoursState();
    } on Exception{
      _concoursStateStream.value = ConcoursFailure(error: 'Unknown error occurred.');
    }
  }
}