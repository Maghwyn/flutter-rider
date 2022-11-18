import 'package:flutter_project/models/user.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserState {
  late User user;
  UserState();
  UserState.fill(this.user);

  User get props => user;
}

class UsersListState {
  late RxList<User> users = RxList<User>();

  UsersListState();
  UsersListState.fill(this.users);

  deleteUser(ObjectId userId) {
    users.removeWhere((element) => element.id == userId);
  }

  List<User> get props => users;
}