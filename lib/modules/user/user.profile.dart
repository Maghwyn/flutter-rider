import 'package:flutter/material.dart';

import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

import '../auth/signup/signup.controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _controller = Get.put(SignupController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));

    return Column(children: [
      Center(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20), //apply padding to all four sides
          ),
          const Image(
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
          ),
          const Padding(
            padding: EdgeInsets.all(10), //apply padding to all four sides
          ),
          Text(
            uc.user.name,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Padding(
            padding: EdgeInsets.all(10), //apply padding to all four sides
          ),
          Text(
            uc.user.email,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const Padding(
            padding: EdgeInsets.all(10), //apply padding to all four sides
          ),
        ]),
      ),
    ]);
  }
}
