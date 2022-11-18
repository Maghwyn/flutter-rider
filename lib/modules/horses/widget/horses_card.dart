import 'package:flutter/material.dart';
import 'package:flutter_project/models/horse.dart';
import 'package:flutter_project/modules/horses/horses.controller.dart';
import 'package:flutter_project/modules/horses/horses.service.dart';
import 'package:flutter_project/modules/horses/widget/horses_form_edit.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class HorseCard extends StatefulWidget {
  const HorseCard({
    super.key,
    required this.horse,
    required this.name,
    required this.age,
    required this.robe,
    required this.race,
    required this.sexe,
    required this.picture,
    required this.isMine,
  });

  final Horse horse;
  final String name;
  final String age;
  final String robe;
  final String race;
  final String picture;
  final String sexe;
  final bool isMine;

  @override
  State<HorseCard> createState() => _HorseCard();
}

class _HorseCard extends State<HorseCard> {
  @override
  Widget build(BuildContext context) {
    HorsesController hc = Get.put(HorsesController(Get.put(HorsesService())));
    UserController uc = Get.put(UserController(Get.put(UserService())));

   return Material(
    child: SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () async {
          if(uc.user.role[0] != "USER") {
            hc.getSingleHorse(widget.horse);
            Get.to(const HorsesEditForm());
          }
        },
      child: Card(
          child: ClipPath(
            clipper: ShapeBorderClipper(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3))),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.picture),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      width: 1.5
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    spacing: 10,
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        spacing: 4,
                        children: [
                          Text(widget.name,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.age,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.robe,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.race,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Text(widget.sexe,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: widget.isMine ? const Icon(Icons.person, color: Colors.purple, size: 40) : null,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ));
  }
}