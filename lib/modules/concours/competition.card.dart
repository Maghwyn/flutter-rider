import 'package:flutter/material.dart';
import 'package:flutter_project/modules/concours/participant_competition/participant_competition.form.dart';
import 'package:get/get.dart';

import '../../models/competition.dart';
import 'competition.controller.dart';
import 'competition.service.dart';

class CompetitionCard extends StatefulWidget {
  const CompetitionCard({
    super.key,
    required this.competition,
    required this.name,
    required this.date,
    required this.adress,
    required this.picture,
  });

  final Competition competition;
  final String name;
  final DateTime date;
  final String adress;
  final String picture;

  @override
  State<CompetitionCard> createState() => _CompetitionCard();
}

class _CompetitionCard extends State<CompetitionCard> {
  CompetitionsController cc = Get.put(CompetitionsController(Get.put(CompetitionsService())));

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
          width: double.infinity,
          child: GestureDetector(
            onTap: () async {
                cc.getSingleCompetition(widget.competition);
                Get.to(const CompetitionParticipationForm());
            },
            child: Card(
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Column(
                          children: [
                            Text(widget.name),
                            Text(widget.date.toString()),
                            Text(widget.adress),
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