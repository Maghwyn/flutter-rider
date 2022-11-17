import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project/modules/admin/admin.controller.dart';
import 'package:flutter_project/modules/admin/admin.service.dart';
import 'package:get/get.dart';

const List<Widget> adminNames = <Widget>[
  Text('Courses'),
  Text('Parties'),
];

class AdminValidatorPage extends StatelessWidget {
  const AdminValidatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: AdminValidatorSwitch(),
      )
    );
  }
}

class AdminValidatorSwitch extends StatefulWidget {
  const AdminValidatorSwitch({super.key});

  @override
  State<StatefulWidget> createState() => _AdminValidatorSwitch();
}

class _AdminValidatorSwitch extends State<AdminValidatorSwitch> {
  AdminController ad = Get.put(AdminController(Get.put(AdminService())));
  final List<bool> _selectedSubPage = <bool>[true, false];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Wrap(
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          ToggleButtons(
            direction: Axis.horizontal,
            onPressed: (int index) => {
              setState(() {
                for (int i = 0; i < _selectedSubPage.length; i++) {
                  _selectedSubPage[i] = i == index;
                }
              }),
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
            isSelected: _selectedSubPage,
            children: adminNames,
          ),
          Divider(
            height: 5,
            thickness: 1,
            indent: 0,
            endIndent: 0,
            color: Colors.grey[300],
          ),
          SizedBox(
            width: double.infinity,
            height: 700,
            child: Obx(
                  () => ListView(
                children: _selectedSubPage[0] ? ad.courses : ad.parties,
              ),
            ),
          ),
        ],
      )
    );
  }
}