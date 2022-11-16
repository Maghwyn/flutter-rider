import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user.form.dart';
import 'package:flutter_project/modules/user/user.profile.dart';
import 'package:flutter_project/modules/user/users_horses.form.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';

import '../../layout/app/app.layout.controller.dart';
import '../placeholder/page.dart';

class UserHorsesEditPage extends StatelessWidget {
  const UserHorsesEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLayoutController>(
      init: AppLayoutController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('UserHorsesEdit'),
          ),
          body: const UserHorsesForm(),
        );
      },
    );
  }
}
