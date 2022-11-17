import 'package:mongo_dart/mongo_dart.dart';

class Party {
  final ObjectId? id;
  final ObjectId? userId;
  final List<dynamic> partipantsId;
  final String title;
  final DateTime? createdAt;
  final String type;
  final DateTime date;

  Party({
    this.id,
    this.userId,
    required this.partipantsId,
    required this.title,
    required this.type,
    required this.date,
    this.createdAt,
  });
}