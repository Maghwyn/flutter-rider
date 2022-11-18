import 'package:mongo_dart/mongo_dart.dart';

class User {
  final ObjectId? id;
  final String name;
  final String email;
  final DateTime createdAt;
  final List<dynamic> role;
  final String picture;
  final String? number;
  final String? age;

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
  String toString() =>
      'User { name: $name, email: $email, id: $id, createAt: $createdAt, role: $role, picture:$picture, number:$number, age:$age}';
}
