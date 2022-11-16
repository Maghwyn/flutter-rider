import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user_edit.page.dart';
import 'package:flutter_project/modules/user/user.form.dart';
import 'package:flutter_project/modules/user/user.profile.dart';
import 'package:flutter_project/modules/user/user_edit_horses.dart';
import 'package:flutter_project/modules/user/users_horses.form.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/route_manager.dart';

import '../../layout/app/app.layout.controller.dart';
import '../placeholder/page.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLayoutController>(
      init: AppLayoutController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('UserPage'),
          ),
          endDrawer: Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.purple,
                  ),
                  child: Text('Profile'),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),
                  title: const Text('Edit Account'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserEditPage(),
                  )),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit_note,
                  ),
                  title: const Text('Edit Horses'),
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserHorsesEditPage(),
                  )),
                ),
              ],
            ),
          ),
          body: const UserProfile(),
        );
      },
    );
  }
}
