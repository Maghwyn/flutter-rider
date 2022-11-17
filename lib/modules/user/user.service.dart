import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/models/user.dart';
import 'package:mongo_dart/mongo_dart.dart'
    show DbCollection, ObjectId, WriteResult;
import 'package:get/get.dart';

import 'package:flutter_project/config/mongo.dart';

abstract class UserServiceTemplate extends GetxService {
  Future<RxList<User>> _getUser();
  Future<User> updateUsers(User user);

  updateUser(User user) {}
}

class UserService extends UserServiceTemplate {
  final DbCollection _users = inject<DBConnection>().getCollection("users");

  final User _user = inject<User>();

  @override
  Future<RxList<User>> _getUser() async {
    final DateTime now = DateTime.now();
    final DateTime week = DateTime(now.year, now.month, now.day + 7);

    final usersDocuments = await _users.find({
      "date": {
        r"$lte": week,
      }
    }).toList();
    late RxList<User> users = RxList<User>();

    for (var n = 0; n < usersDocuments.length; n++) {
      var user = usersDocuments[n];

      users.add(User(
        id: user["_id"],
        name: user["name"],
        email: user["email"],
        createdAt: user["createdAt"],
        picture: user["picture"] as String,
        role: user["role"] as List<dynamic>,
      ));
    }

    return users;
  }

  @override
  Future<User> updateUsers(User user) async {
    print(user);
    WriteResult mongoDocument = await _users.updateOne({
      "id": user.id,
    }, {
      "name": user.name,
      "email": user.email,
    });

    final mongoUser = mongoDocument.document;
    return User(
      id: mongoDocument.id as ObjectId,
      name: mongoUser!["name"] as String,
      email: mongoUser["email"] as String,
      createdAt: mongoUser["createdAt"] as DateTime,
      picture: mongoUser["picture"] as String,
      role: mongoUser["role"] as List<dynamic>,
    );
  }
}
