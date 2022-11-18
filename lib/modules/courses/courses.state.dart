import 'package:equatable/equatable.dart';
import 'package:flutter_project/models/course.dart';
import 'package:get/get.dart';

class CoursesState {
  late RxList<Course> courses = RxList<Course>();

  CoursesState();
  CoursesState.fill(this.courses);

  addCourse(Course course) {
    courses.add(course);
  }

  deleteCourse(Course course) {
    courses.remove(course);
  }

  List<Course> get props => courses;
}

class CourseFormState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseFormLoading extends CourseFormState {}

class CourseFormFailure extends CourseFormState {
  final String error;

  CourseFormFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class CourseVisualState extends Equatable {
  @override
  List<Object> get props => [];
}

class CourseVisualToggle {
  late bool checked;
  CourseVisualToggle();
  CourseVisualToggle.checked(this.checked);
  bool get props => checked;
}

class CourseShowFinished extends CourseVisualState {}
class CourseUnshowFinished extends CourseVisualState {}