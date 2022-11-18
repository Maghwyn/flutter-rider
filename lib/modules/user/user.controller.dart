import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:flutter_project/modules/user/user.state.dart';
import 'package:flutter_project/modules/user/user_remove/user_card.dart';
import 'package:get/get.dart';
import 'package:mongo_dart/mongo_dart.dart';

class UserController extends GetxController {
  final _userStateStream = UserState().obs;
  final _usersListStateStream = UsersListState().obs;

  final User _user = inject<User>();

  final AuthenticationController _authenticationController = Get.find();

  final UserServiceTemplate _userService;

  UserController(this._userService);

  List<Widget> get usersList => _usersListStateStream.value.users.map((user) =>
    UserCard(
      id: user.id!,
      name: user.name,
      email: user.email,
      createdAt: user.createdAt,
      picture: user.picture,
    )
  ).toList();

  User get user => _userStateStream.value.user;

  @override
  void onInit() {
    _getUsers();
    super.onInit();
  }

  void signOut() {
    _authenticationController.signOut();
  }

  void deleteUser(ObjectId userId) async {
    await _userService.deleteUser(userId);
    _usersListStateStream.value.deleteUser(userId);
  }

  Future<void> _getUsers() async {
    RxList<User> userList = await _userService.getUsers();
    _userStateStream.value = UserState.fill(_user);
    _usersListStateStream.value = UsersListState.fill(userList);
  }
  
  @override
  void dispose() {
    Get.delete<UserController>();
    super.dispose();
    Get.lazyPut(() => UserController(Get.put(UserService())));
  }

  Future<bool> reset() async {
    _userStateStream.value = UserState();
    return true;
  }

  Future<bool> set(User user) async {
    _userStateStream.value = UserState.fill(user);
    return true;
  }

  void setDpRole(bool x) async {
    final mongoUser = await _userService.setDpRole(x);
    unregisterLoggedUserLocator();
    setupLoggedUserLocator(mongoUser);
    _userStateStream.value = UserState.fill(mongoUser);
  }
  
  void updateUser(User user) async {
    final mongoUser = await _userService.updateUsers(user);
    unregisterLoggedUserLocator();
    setupLoggedUserLocator(mongoUser);
    _userStateStream.value = UserState.fill(mongoUser);
    Get.back();
  }
}
