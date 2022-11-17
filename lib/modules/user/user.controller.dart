import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/user/user.state.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _userStateStream = UserState().obs;

  final User _user = inject<User>();

  final AuthenticationController _authenticationController = Get.find();

  User get user => _userStateStream.value.props;

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
}
