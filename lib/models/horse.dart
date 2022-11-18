import 'package:mongo_dart/mongo_dart.dart';

class Horse {
  final ObjectId? id;
  final ObjectId? userId;
  final String name;
  final String age;
  final DateTime? createdAt;
  final String race;
  final String robe;
  final String sexe;
  final String picture;

  Horse({
    this.id,
    this.userId,
    required this.name, 
    required this.picture,
    required this.age,
    this.createdAt,
    required this.robe,
    required this.race,
    required this.sexe,
  });
}