import 'package:flutter/material.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/auth/login/login.controller.dart';
import 'package:flutter_project/modules/auth/login/login.state.dart';
import 'package:get/get.dart';

class LoginVerifyEmail extends StatelessWidget {
  const LoginVerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _LoginVerifyEmail(),
      )
    );
  }
}

class _LoginVerifyEmail extends StatefulWidget {
  @override
  __LoginVerifyEmail createState() => __LoginVerifyEmail();
}

class __LoginVerifyEmail extends State<_LoginVerifyEmail> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Form(
      key: _key,
      autovalidateMode:
        _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 18,
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[

            const Text("Enter your email adress :"),

            _textFormField(CustomTextField(
              labelText: "Email",
              hintText: "example@gmail.com",
              controller: _emailController,
              validatorType: "email")
            ),

            ElevatedButton(
              onPressed: () => _onCommentButtonPressed(),
              child: const Text('Participate'),
            ),
            if (_controller.state is LoginFailure) (
              Text(
                (_controller.state as LoginFailure).error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Get.theme.errorColor),
              )
            ),
            if (_controller.state is LoginLoading) (
              const Center(
                child: CircularProgressIndicator(),
              )
            ),
          ],
        ),
      )),
    );
  }

  _onCommentButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.verifyEmail(_emailController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  _textFormField(CustomTextField textField) {
    return TextFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: textField.labelText,
        hintText: textField.hintText,
        filled: true,
        isDense: true,
      ),
      obscureText: textField.validatorType == "password",
      keyboardType: textField.validatorType == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      controller: textField.controller,
      validator: (value) => textField.getValidator(value),
    );
  }
}