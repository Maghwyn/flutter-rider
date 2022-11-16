import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/auth/login/login.controller.dart';
import 'package:flutter_project/modules/auth/login/login.state.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: _SignInForm()
    );
  //     body: SizedBox(
  //       width: double.infinity,
  //       height: double.infinity,
  //       // minimum: const EdgeInsets.all(16),
  //       child: Text("Bullshit")/*_SignInForm()*/,
  //     )
  //   );
  }
}

class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {
  final _controller = Get.put(LoginController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
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
                onPressed: _controller.state is LoginLoading
                    ? () {}
                    : _onLoginButtonPressed,
                child: const Text('LOG IN'),
              ),
              if (_controller.state is LoginFailure)
                Text(
                  (_controller.state as LoginFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is LoginLoading)
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
      validator: (value) => textField.getValidator(value)
    );
  }

  _onLoginButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.login(_emailController.text, _passwordController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}