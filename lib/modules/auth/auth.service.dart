import 'package:mongo_dart/mongo_dart.dart' show DbCollection;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';

abstract class AuthenticationServiceTemplate extends GetxService {
  Future<User?> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

/// This class simulate the login with hardcoded data.
class FakeAuthenticationService extends AuthenticationServiceTemplate {
  final DbCollection _users = inject<DBConnection>().getCollection("users");

  @override
  Future<User?> getCurrentUser() async {
    // simulated delay
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    Map<String, dynamic>? mongoDocument = await _users.findOne({
      "email": email,
      "password": password,
    });

    if(mongoDocument == null) {
      throw AuthenticationException(message: 'Invalid credentials');
    }

    return User(name: 'Test User', email: email);
  }

  @override
  Future<void> signOut() async {}
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred.'});
}