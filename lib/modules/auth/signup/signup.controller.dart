import 'package:flutter_project/modules/auth/auth.controller.dart';
import 'package:flutter_project/modules/auth/auth.service.dart';
import 'package:flutter_project/modules/auth/signup/signup.state.dart';
import 'package:get/get.dart';

class SignupController  extends GetxController {
  final AuthenticationController _authenticationController = Get.find();

  final _signupStateStream = SignupState().obs;

  SignupState get state => _signupStateStream.value;

  void signup(String email, String password) async {
    _signupStateStream.value = SignupLoading();

    try{
      await _authenticationController.signIn(email, password);
      _signupStateStream.value = SignupState();
    } on AuthenticationException catch(e){
      _signupStateStream.value = SignupFailure(error: e.message);
    }
  }
}