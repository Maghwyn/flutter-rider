import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  void signOut() {
    _authenticationController.signOut();
  }
}
