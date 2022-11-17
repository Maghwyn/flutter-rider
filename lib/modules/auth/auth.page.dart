import 'package:flutter/material.dart';
import 'package:flutter_project/modules/auth/login/login.page.dart';
import 'package:flutter_project/modules/auth/signup/signup.page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: _AuthSwitch(),
      ),
    );
  }
}

class _AuthSwitch extends StatefulWidget {
  const _AuthSwitch({super.key});

  @override
  __AuthSwitchState createState() => __AuthSwitchState();
}

const List<Widget> authNames = <Widget>[
  Text('Login'),
  Text('Sign Up'),
];

class __AuthSwitchState extends State<_AuthSwitch> {
  final List<bool> _selectedAuth = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Wrap(
          runSpacing: 20,
          alignment: WrapAlignment.center,
          children: [
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedAuth.length; i++) {
                    _selectedAuth[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.purple,
              selectedColor: Colors.white,
              fillColor: Colors.purple[200],
              color: Colors.purple[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedAuth,
              children: authNames,
            ),
            Column(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _selectedAuth[0] ? const LoginPage() : const SignupPage(),
              ],
            )
          ],
        ),
      ),
    );
  }
}