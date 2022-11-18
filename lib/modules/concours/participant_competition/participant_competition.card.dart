import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../competition.controller.dart';
import '../competition.service.dart';

class ParticipantCard extends StatefulWidget {
  const ParticipantCard({
    super.key,
    required this.name,
    required this.picture,
  });

  final String name;
  final String picture;

  @override
  State<ParticipantCard> createState() => _ParticipantCard();
}

class _ParticipantCard extends State<ParticipantCard> {
  CompetitionsController cc = Get.put(CompetitionsController(Get.put(CompetitionsService())));

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
            width: double.infinity,
            child: GestureDetector(
                child: Card(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Center(
                            child: Column(
                              children: [
                                Text(widget.name),
                                Image(image: NetworkImage(widget.picture),),
                              ],
                            )
                        )
                    )
                )
            )
        )
    );
  }
}