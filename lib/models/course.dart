import 'package:mongo_dart/mongo_dart.dart';

class Course {
  final ObjectId? id;
  final ObjectId? userId;
  final String terrain;
  final DateTime date;
  final DateTime? createdAt;
  final String duration;
  final String speciality;
  final String status;

  Course({
    this.id,
    this.userId,
    required this.terrain, 
    required this.date,
    this.createdAt,
    required this.duration,
    required this.speciality,
    required this.status
  });
}