import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user.form.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../layout/app/app.layout.controller.dart';

class UserEditPage extends StatelessWidget {
  const UserEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'EditUser',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const UserForm(),
    );
  }
}
