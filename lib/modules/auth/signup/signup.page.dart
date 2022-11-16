import 'package:flutter/material.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/auth/signup/signup.controller.dart';
import 'package:flutter_project/modules/auth/signup/signup.state.dart';
import 'package:get/get.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: _SignUpForm(),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  @override
  __SignUpFormState createState() => __SignUpFormState();
}

class __SignUpFormState extends State<_SignUpForm> {
  final _controller = Get.put(SignupController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
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
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _textFormField(CustomTextField(
                labelText: "Name",
                hintText: "Jeane Dark",
                controller: _nameController,
                validatorType: "name"
              )),
              _textFormField(CustomTextField(
                labelText: "Email",
                hintText: "example@gmail.com",
                controller: _emailController,
                validatorType: "email"
              )),
              _textFormField(CustomTextField(
                labelText: "Password",
                hintText: "strong password",
                controller: _passwordController, 
                validatorType: "password"
              )),
              ElevatedButton(
                onPressed: _controller.state is SignupLoading
                    ? () {}
                    : _onsignupButtonPressed,
                child: const Text('SIGN UP'),
              ),
              if (_controller.state is SignupFailure)
                Text(
                  (_controller.state as SignupFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is SignupLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      );
    });
  }

  dynamic _textFormField(CustomTextField textField) {
    return TextFormField(
      decoration: InputDecoration(
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

  _onsignupButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.signup(_nameController.text, _emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}