
import 'package:flutter_project/models/horse.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class HorsesState {
  late RxList<Horse> horses = RxList<Horse>();

  HorsesState();
  HorsesState.fill(this.horses);

  addCourse(Horse horse) {
    horses.add(horse);
  }

  deleteHorse(ObjectId horseId) {
    horses.removeWhere((element) => element.id == horseId);
  }

  List<Horse> get props => horses;
}

class SingleHorseState {
  late Horse horse;
  SingleHorseState();
  SingleHorseState.fill(this.horse);
  Horse get props => horse;
}