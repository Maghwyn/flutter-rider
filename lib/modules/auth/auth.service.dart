import 'package:mongo_dart/mongo_dart.dart' show DbCollection, ModifierBuilder, ObjectId, WriteResult, where;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/src/database/commands/query_and_write_operation_commands/return_classes/write_result.dart';

abstract class AuthenticationServiceTemplate extends GetxService {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> singUpCredentials(String name, String email, String password);
  Future<void> verifyEmail(String email);
  Future<void> resetPassword(String password, String email);
  Future<void> signOut();
}

/// This class simulate the login with hardcoded data.
class AuthenticationService extends AuthenticationServiceTemplate {
  final DbCollection _users = inject<DBConnection>().getCollection("users");

  /// Used for the auth persistance, it's not a necessary requirement for the project.
  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    Map<String, dynamic>? user = await _users.findOne({
      "email": email,
      "password": password,
    });

    if(user == null) {
      throw AuthenticationException(message: 'Invalid credentials');
    }

    return User(
      id: user["_id"],
      name: user["name"],
      email: user["email"],
      createdAt: user["createdAt"],
      picture: user["picture"] as String,
      role: user["role"] as List<dynamic>,
      number: user["number"],
      age: user["age"],
    );
  }

  @override
  Future<void> verifyEmail(String email) async {
    Map<String, dynamic>? userExist = await _users.findOne({
      "email": email,
    });

    if(userExist == null) {
      throw AuthenticationException(message: 'Email does not exist');
    }
  }

  @override
  Future<void> resetPassword(String password, String email) async {
    await _users.updateOne(
      where.eq("email", email),
      ModifierBuilder()
        .set("password", password)
    );
  }

  @override
  Future<void> signOut() async {}
  
  @override
  Future<User> singUpCredentials(String name, String email, String password) async {
    Map<String, dynamic>? userExist = await _users.findOne({
      "email": email,
    });

    if(userExist != null) {
      throw AuthenticationException(message: 'Email is already in use');
    }

    WriteResult mongoDocument = await _users.insertOne({
      "name": name,
      "email": email,
      "password": password,
      "createdAt": DateTime.now(),
      "picture": "https://t3.ftcdn.net/jpg/03/58/90/78/360_F_358907879_Vdu96gF4XVhjCZxN2kCG0THTsSQi8IhT.jpg",
      "role": ["USER"],
    });

    final user = mongoDocument.document;
    return User(
      id: mongoDocument.id as ObjectId,
      name: user!["name"] as String,
      email: user["email"] as String,
      createdAt: user["createdAt"] as DateTime,
      picture: user["picture"] as String,
      role: user["role"] as List<dynamic>,
      number: user["number"] as String,
      age: user["age"] as String,
    );
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred.'});
}