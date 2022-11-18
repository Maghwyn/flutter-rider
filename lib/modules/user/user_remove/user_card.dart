import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/horses/horses.controller.dart';
import 'package:flutter_project/modules/horses/horses.service.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongo;

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.picture,
  });

  final mongo.ObjectId id;
  final String name;
  final String email;
  final DateTime createdAt;
  final String picture;

  @override
  State<UserCard> createState() => _UserCard();
}

class _UserCard extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));
    HorsesController hc = Get.put(HorsesController(Get.put(HorsesService())));
    final User _user = inject<User>();

    return Material(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.deepPurple[50],
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3))),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Wrap(
                    spacing: 20,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.picture),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 1.5
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                      ),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        children: [
                          Wrap(
                            direction: Axis.vertical,
                            spacing: 10,
                            children: [
                              Text(widget.name,
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Text(widget.email,
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              Text("- ${DateFormat("yyyy-MM-dd").format(widget.createdAt)}",
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]
                  ),
                  if(_user.role[0] == "ADMIN" && widget.id != _user.id) (
                    Wrap(
                      direction: Axis.horizontal,
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          crossAxisAlignment: WrapCrossAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                  uc.deleteUser(widget.id);
                                  hc.forceRefreshHorse();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ]
                    )
                  )
                ]
              )
            ),
          )
        )
      ),
    );
  }
}