import 'package:mongo_dart/mongo_dart.dart';

class Competition {
  final ObjectId? id;
  final String name;
  final String date;
  final String adress;
  final DateTime createdAt;
  final String picture;
  final List<ObjectId>? participant;

  Competition({
    this.id,
    required this.name,
    required this.date,
    required this.adress,
    required this.createdAt,
    required this.picture,
    this.participant,
  });

  @override
  String toString() => 'Competition { name: $name, date: $date}';
}