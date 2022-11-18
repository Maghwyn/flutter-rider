import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart'
    show DbCollection, ModifierBuilder, where;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class UserServiceTemplate extends GetxService {
  Future<User> _getUser();
  Future<User> updateUsers(User user);
  Future<User> setDpRole(bool x);
  updateUser(User user) {}
}

class UserService extends UserServiceTemplate {
  final DbCollection _users = inject<DBConnection>().getCollection("users");
  final User _user = inject<User>();

  @override
  Future<User> _getUser() async {
    final user = await _users.findOne({"_id": _user.id});

    return User(
      id: user!["_id"],
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
  Future<User> updateUsers(User user) async {
    await _users.updateOne(
      where.eq("_id", _user.id),
      ModifierBuilder()
        .set("name", user.name)
        .set("email", user.email)
        .set("number", user.number)
        .set("age", user.age)
        .set("picture", user.picture)
    );

    return await _getUser();
  }

  @override
  Future<User> setDpRole(bool x) async {
    await _users.updateOne(
      where.eq("_id", _user.id),
      ModifierBuilder()
        .set("role", x ? ["DP_CAVALIER"] : ["USER"])
    );

    return await _getUser();
  }
}
