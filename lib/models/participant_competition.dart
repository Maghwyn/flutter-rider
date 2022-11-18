import 'package:mongo_dart/mongo_dart.dart';

class CompetitionParticipant {
  final ObjectId? id;
  final ObjectId? user;
  final ObjectId? competition;
  final String categorie;
  final DateTime? createdAt;

  CompetitionParticipant({
    this.id,
    this.user,
    this.competition,
    required this.categorie,
    this.createdAt,
  });

  @override
  String toString() => 'Competition { name: $user, competition: $competition}';
}