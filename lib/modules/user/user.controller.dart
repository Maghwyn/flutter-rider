import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:flutter_project/modules/user/user.state.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userStateStream = UserState().obs;

  final User _user = inject<User>();

  final AuthenticationController _authenticationController = Get.find();

  final UserServiceTemplate _userService;

  UserController(this._userService);

  User get user => _userStateStream.value.user;

  @override
  void onInit() {
    _getUser();
    super.onInit();
  }

  void signOut() {
    _authenticationController.signOut();
  }

  void _getUser() {
    _userStateStream.value = UserState.fill(_user);
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
