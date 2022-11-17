import 'package:equatable/equatable.dart';

class ParticipantState extends Equatable {
  @override
  List<Object> get props => [];
}

class ParticipantLoading extends ParticipantState {}

class ParticipantFailure extends ParticipantState {
  final String error;

  ParticipantFailure({required this.error});

  @override
  List<Object> get props => [error];
}