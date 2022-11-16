import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignupLoading extends SignupState {}

class SignupFailure extends SignupState {
  final String error;

  SignupFailure({required this.error});

  @override
  List<Object> get props => [error];
}