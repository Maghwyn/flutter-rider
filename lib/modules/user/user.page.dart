import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user_edit.page.dart';
import 'package:flutter_project/modules/user/user.profile.dart';
import 'package:flutter_project/modules/user/user_edit_horses.page.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UserPage',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              accountName: Text(
                uc.user.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                uc.user.email,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
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
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () => uc.signOut(),
            ),
          ],
        ),
      ),
      body: const UserProfile(),
    );
  }
}
