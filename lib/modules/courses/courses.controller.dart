import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/courses/courses.card.dart';
import 'package:flutter_project/modules/courses/courses.service.dart';
import 'package:flutter_project/modules/courses/courses.state.dart';
import 'package:get/get.dart';

class CoursesController  extends GetxController {
  final CoursesServiceTemplate _coursesService;
  final _coursStateStream = CoursesState().obs;
  final _coursStateFormStream = CourseFormState().obs;
  final User _user = inject<User>();

  List<Widget> get courses => _coursStateStream.value.courses.map((el) =>
    CourseCard(
      terrain: el.terrain,
      date: el.date,
      duration: el.duration,
      speciality: el.speciality,
      isMine: _user.id == el.userId,
  )).toList();

  CourseFormState get stateForm => _coursStateFormStream.value;

  CoursesController(this._coursesService);

  @override
  void onInit() {
    _getCourses();
    super.onInit();
  }

  // void _sortCourse() {
  //   _coursStateStream.value.courses.sort((a,b) => -a.date.compareTo(b.date));
  // }

  void addCourse(Course course) async {
    final mongoCourse = await _coursesService.addCourse(course);
    _coursStateStream.value.addCourse(mongoCourse);
    // _sortCourse();
    Get.back();
  }

  void removeCourse(Course course) async {
    final res = await _coursesService.deleteCourse(course);

    _coursStateStream.value.deleteCourse(course);
  }

  void _getCourses() async {
    final coursesList = await _coursesService.getCourses();
    // _sortCourse();

    if (coursesList.isEmpty) {
      _coursStateStream.value = CoursesState();
    } else {
      _coursStateStream.value = CoursesState.fill(coursesList);
    }
  }
}