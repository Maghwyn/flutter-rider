import 'package:equatable/equatable.dart';

class CoursState extends Equatable {
  @override
  List<Object> get props => [];
}

class CoursLoading extends CoursState {}

class CoursFailure extends CoursState {
  final String error;

  CoursFailure({required this.error});

  @override
  List<Object> get props => [error];
}