import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {}

class UserFailure extends UserState {
  final String error;

  UserFailure({required this.error});

  @override
  List<Object> get props => [error];
}
