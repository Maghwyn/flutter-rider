import 'package:equatable/equatable.dart';
import 'package:flutter_project/models/user.dart';

class UserFormState {
  late User user;
  UserFormState();
  UserFormState.fill(this.user);

  User get props => user;
}

class UserFormLoading extends UserFormState {}

// class UserFormFailure extends UserFormState {
//   final String error;

//   UserFormFailure({required this.error});

//   @override
//   List<Object> get props => [error];
// }