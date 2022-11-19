import 'package:flutter/material.dart';
import 'package:flutter_project/modules/admin/admin.service.dart';
import 'package:flutter_project/modules/admin/admin.state.dart';
import 'package:flutter_project/modules/admin/widget/admin_course_card.dart';
import 'package:flutter_project/modules/courses/courses.state.dart';
import 'package:flutter_project/modules/parties/widget/parties_card.dart';
import 'package:get/get.dart';

import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/parties/parties.state.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AdminController  extends GetxController {
  final AdminServiceTemplate _adminService;
  final _adminToggleStateStream = AdminToggleState().obs;
  final _partiesStateStream = PartiesState().obs;
  final _coursesStateStream = AdminCoursesState().obs;

  final User _user = inject<User>();

  List<Widget> get parties => _partiesStateStream.value.parties.map((party) =>
    PartyCard(
      party: party,
      title: party.title,
      date: party.date,
      type: party.type,
      participants: party.partipantsId.length,
      isMine: _user.id == party.userId,
      status: party.status,
      canOpen: true,
  )).toList();

  List<Widget> get courses => _coursesStateStream.value.courses.map((course) =>
    AdminCourseCard(
      courseId: course.id!,
      terrain: course.terrain,
      date: course.date,
      duration: course.duration,
      speciality: course.speciality,
      status: course.status,
  )).toList();

  List<bool> get currentSubpage => _adminToggleStateStream.value.selectedSubPage;

  AdminController(this._adminService);

  @override
  void onInit() {
    _getParties();
    _getCourses();
    super.onInit();
  }

  void toggleSubPage(int index) {
    _adminToggleStateStream.value.changeTabIndex(index);
  }

  void validateParty(ObjectId partyId, String status) async {
    await _adminService.updatePartyStatus(partyId, status);
    _partiesStateStream.value.removeById(partyId);
    Get.back();
  }

  void validateCourse(ObjectId courseId, String status) async {
    await _adminService.updateCourseStatus(courseId, status);
    _coursesStateStream.value.removeById(courseId);
  }

  void _getParties() async {
    final partiesList = await _adminService.getParties();

    if (partiesList.isEmpty) {
      _partiesStateStream.value = PartiesState();
    } else {
      _partiesStateStream.value = PartiesState.fill(partiesList);
    }
  }

  void _getCourses() async {
    final coursesList = await _adminService.getCourses();

    if (coursesList.isEmpty) {
      _coursesStateStream.value = AdminCoursesState();
    } else {
      _coursesStateStream.value = AdminCoursesState.fill(coursesList);
    }
  }
}