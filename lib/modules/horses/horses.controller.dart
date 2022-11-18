import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/horse.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/horses/horses.service.dart';
import 'package:flutter_project/modules/horses/horses.state.dart';
import 'package:flutter_project/modules/horses/widget/horses_card.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class HorsesController  extends GetxController {
  final HorsesServiceTemplate _horsesService;
  final _horseStateStream = HorsesState().obs;
  final _singleHorseStateStream = SingleHorseState().obs;
  // final _coursStateFormStream = CourseFormState().obs;
  // final _coursVisualStateStream = CourseVisualState().obs;
  final User _user = inject<User>();

  List<Widget> get horses => _horseStateStream.value.horses
  .map((horse) =>
    HorseCard(
      horse: horse,
      name: horse.name,
      age: horse.age,
      robe: horse.robe,
      race: horse.race,
      sexe: horse.sexe,
      picture: horse.picture,
      isMine: horse.userId == _user.id,
    )
  ).toList();

  Horse get horse => _singleHorseStateStream.value.horse;

  // CourseFormState get stateForm => _coursStateFormStream.value;

  HorsesController(this._horsesService);

  @override
  void onInit() {
    _getHorses();
    super.onInit();
  }

  // void _sortCourse() {
  //   _horseStateStream.value.horses.sort((a,b) => -b.date.compareTo(a.date));
  // }

  Future<void> reset() async {
    final RxList<Horse> horses = RxList<Horse>();
    _horseStateStream.value = HorsesState.fill(horses);
    // _coursStateFormStream.value = CourseFormState();
    Get.delete<HorsesController>();
    Get.lazyPut(() => HorsesController(Get.put(HorsesService())));
  }

  Future<bool> set() async {
    final horsesList = await _horsesService.getHorses();
    // _sortCourse();

    if (horsesList.isEmpty) {
      _horseStateStream.value = HorsesState();
    } else {
      _horseStateStream.value = HorsesState.fill(horsesList);
    }
    return true;
  }

  void getSingleHorse(Horse horse) async {
     _singleHorseStateStream.value = SingleHorseState.fill(horse);
  }

  void addHorse(Horse horse) async {
    final mongoHorse = await _horsesService.addHorse(horse);
    _horseStateStream.value.addCourse(mongoHorse);
    // _sortCourse();
    Get.back();
  }
  void setMyHorse(bool x, ObjectId horseId) async {
    Horse horseUpdate = await _horsesService.setMyHorse(x, horseId);
     _singleHorseStateStream.value = SingleHorseState.fill(horseUpdate);
    RxList<Horse> horseList = await _horsesService.getHorses();
     _horseStateStream.value = HorsesState.fill(horseList);
  }

  void editHorse(Horse horse, ObjectId horseId) async {
    RxList<Horse> horseList = await _horsesService.editHorse(horse, horseId);
    _horseStateStream.value = HorsesState.fill(horseList);
    Get.back();
  }

  void deleteHorse(ObjectId horseId) async {
    await _horsesService.deleteHorse(horseId);
    _horseStateStream.value.deleteHorse(horseId);
    Get.back();
  }

  void _getHorses() async {
    final horsesList = await _horsesService.getHorses();
    // _sortCourse();

    if (horsesList.isEmpty) {
      _horseStateStream.value = HorsesState();
    } else {
      _horseStateStream.value = HorsesState.fill(horsesList);
    }
  }
}