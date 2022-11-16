import 'package:flutter_project/modules/cours/cours.state.dart';
import 'package:get/get.dart';

class CoursController  extends GetxController {
  final _coursStateStream = CoursState().obs;

  CoursState get state => _coursStateStream.value;

  void cours(String training, String date_hours, String duration, String speciality) async {
    _coursStateStream.value = CoursLoading();

    try{
      _coursStateStream.value = CoursState();
    } on Exception{
      _coursStateStream.value = CoursFailure(error: 'Unknown error occurred.');
    }
  }
}