import 'package:flutter/material.dart';
import 'package:flutter_project/layout/app/app.layout.controller.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/placeholder/page.dart';
import 'package:get/get.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({super.key, required User user});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppLayoutController>(
      init: AppLayoutController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: const [
                PlaceholderPage(),
                PlaceholderPage(),
                PlaceholderPage(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex,
            selectedItemColor: Colors.purple,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.privacy_tip),
                label: 'Sample 1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.privacy_tip),
                label: 'Sample 2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.privacy_tip),
                label: 'Sample 3',
              ),
            ],
          ),
        );
      },
    );
  }
}