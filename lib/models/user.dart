import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId? id;
  final String name;
  final String email;
  final DateTime createdAt;
  final List<String> role;
  final String picture;
  final int? number;
  final int? age;

  User({
    this.id,
    required this.name, 
    required this.email,
    required this.createdAt,
    required this.role,
    required this.picture,
    this.number,
    this.age,
  });

  @override
  String toString() => 'User { name: $name, email: $email}';
}