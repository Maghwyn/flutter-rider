import 'package:flutter/material.dart';
import 'package:flutter_project/modules/admin/admin.page.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:flutter_project/modules/user/user_edit/user_edit.page.dart';
import 'package:flutter_project/modules/user/user.profile.dart';
import 'package:flutter_project/modules/user/user_horses_edit/user_edit_horses.page.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));

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
        child: Obx(() => ListView(
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
              currentAccountPicture: CircleAvatar(
                child:  Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(uc.user.picture),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 1.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
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
            if(uc.user.role[0] == "ADMIN") (
              ListTile(
                leading: const Icon(
                  Icons.checklist_rtl_outlined,
                ),
                title: const Text('Validate Events'),
                onTap: () => Get.to(const AdminValidatorPage()),
              )
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () => uc.signOut(),
            ),
          ],
        )),
      ),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: UserProfile(),
      )
    );
  }
}
