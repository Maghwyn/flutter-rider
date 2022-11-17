import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user_edit/user.form.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: UserForm(),
      )
    );
  }
}
