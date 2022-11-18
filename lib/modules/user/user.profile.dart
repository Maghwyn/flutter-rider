import 'package:flutter/material.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));
    
    return Scaffold(
      body: Obx(() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Wrap(
          spacing: 20,
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
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
            Text(
              uc.user.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              uc.user.email,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ]
        )
      )
    ));
  }
}
