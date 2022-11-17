import 'package:mongo_dart/mongo_dart.dart';

class ParticipantCompetition {
  final ObjectId? id;
  final ObjectId user;
  final ObjectId competition;
  final String categorie;
  final DateTime createdAt;

  ParticipantCompetition({
    this.id,
    required this.user,
    required this.competition,
    required this.categorie,
    required this.createdAt,
  });

  @override
  String toString() => 'Competition { name: $user, competition: $competition}';
}