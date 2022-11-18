import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/models/party.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class AdminToggleState {
  final List<bool> selectedSubPage = <bool>[true, false];

  void changeTabIndex(int index) {
    for (int i = 0; i < selectedSubPage.length; i++) {
      selectedSubPage[i] = i == index;
    }
  }

  List<Object> get props => selectedSubPage;
}

class AdminPartiesState {
  late RxList<Party> parties = RxList<Party>();

  AdminPartiesState();
  AdminPartiesState.fill(this.parties);

  addParty(Party party) {
    parties.add(party);
  }

  deleteParty(Party party) {
    parties.remove(party);
  }

  List<Party> get props => parties;
}

class AdminCoursesState {
  late RxList<Course> courses = RxList<Course>();

  AdminCoursesState();
  AdminCoursesState.fill(this.courses);

  addCourse(Course course) {
    courses.add(course);
  }

  removeById(ObjectId courseId) {
    courses.removeWhere((element) => element.id == courseId);
  }

  List<Course> get props => courses;
}