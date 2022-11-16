import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user_edit.page.dart';
import 'package:flutter_project/modules/user/user.profile.dart';
import 'package:flutter_project/modules/user/user_edit_horses.page.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../layout/app/app.layout.controller.dart';

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
                const UserAccountsDrawerHeader(
                  accountName: Text(
                    "Name",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  accountEmail: Text(
                    "06 12 12 12 12",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.purple,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://appmaking.co/wp-content/uploads/2021/08/android-drawer-bg.jpeg",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
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
