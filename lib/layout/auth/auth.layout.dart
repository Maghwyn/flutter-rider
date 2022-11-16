import 'package:flutter_project/modules/auth/auth.page.dart';
import 'package:flutter_project/modules/placeholder/page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:flutter_project/layout/auth/auth.layout.controller.dart';

class AuthLayout extends StatelessWidget {
  const AuthLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthLayoutController>(
      init: AuthLayoutController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                PlaceholderPage(),
                AuthPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            selectedItemColor: Colors.purple,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.login),
                label: 'Auth',
              ),
            ],
          ),
        );
      },
    );
  }
}