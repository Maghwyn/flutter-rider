import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/auth/auth.service.dart';
import 'package:flutter_project/modules/auth/login/login.state.dart';
import 'package:flutter_project/modules/auth/login/widget/reset_email.dart';
import 'package:get/get.dart';

class LoginController  extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  final _loginStateStream = LoginState().obs;

  LoginState get state => _loginStateStream.value;

  void verifyEmail(String email) async {
    try{
      await _authenticationController.verifyEmail(email);
      _loginStateStream.value = LoginState();
      Get.to(ResetEmail(email: email));
    } on AuthenticationException catch(e) {
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }

  void resetPassword(String password, String email) async {
    try {
      await _authenticationController.resetPassword(password, email);
      _loginStateStream.value = LoginState();
      Get.back();
      Get.back();
    } on AuthenticationException catch(e) {
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }

  void login(String email, String password) async {
    _loginStateStream.value = LoginLoading();

    try{
      await _authenticationController.signIn(email, password);
      _loginStateStream.value = LoginState();
    } on AuthenticationException catch(e){
      _loginStateStream.value = LoginFailure(error: e.message);
    }
  }
}