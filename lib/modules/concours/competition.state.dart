import 'package:equatable/equatable.dart';

class ConcoursState extends Equatable {
  @override
  List<Object> get props => [];
}

class ConcoursLoading extends ConcoursState {}

class ConcoursFailure extends ConcoursState {
  final String error;

  ConcoursFailure({required this.error});

  @override
  List<Object> get props => [error];
}