import 'package:flutter/material.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/auth/login/login.controller.dart';
import 'package:flutter_project/modules/auth/login/login.state.dart';
import 'package:get/get.dart';

class ResetEmail extends StatelessWidget {
  String email;
  ResetEmail({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _ResetEmail(email: email),
      )
    );
  }
}

class _ResetEmail extends StatefulWidget {
  String email;
  _ResetEmail({super.key, required this.email});
  
  @override
  __ResetEmail createState() => __ResetEmail();
}

class __ResetEmail extends State<_ResetEmail> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _key,
        autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 18,
            spacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[

              const Text("Enter your new password :"),

              _textFormField(CustomTextField(
                labelText: "Password",
                hintText: "Strong password",
                controller: _passwordController,
                validatorType: "password"),
              ),

              ElevatedButton(
                onPressed: () => _onCommentButtonPressed(),
                child: const Text('Confirm'),
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
        ),
      );
    });
  }

  _onCommentButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.resetPassword(_passwordController.text, widget.email);
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