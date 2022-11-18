
import 'package:flutter_project/models/horse.dart';
import 'package:get/get.dart';

class HorsesState {
  late RxList<Horse> horses = RxList<Horse>();

  HorsesState();
  HorsesState.fill(this.horses);

  addCourse(Horse horse) {
    horses.add(horse);
  }

  deleteCourse(Horse horse) {
    horses.remove(horse);
  }

  List<Horse> get props => horses;
}