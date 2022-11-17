import 'package:flutter/material.dart';
import 'package:flutter_project/models/party.dart';
import 'package:flutter_project/modules/party/parties.controller.dart';
import 'package:flutter_project/modules/party/parties.service.dart';
import 'package:flutter_project/modules/party/widget/parties_preview.dart';
import 'package:get/get.dart';

class PartyCard extends StatefulWidget {
  const PartyCard({
    super.key,
    this.party,
    required this.title,
    required this.date,
    required this.participants,
    required this.type,
    required this.isMine,
    required this.canOpen,
  });

  final Party? party;
  final String title;
  final DateTime date;
  final int participants;
  final String type;
  final bool isMine;
  final bool canOpen;

  @override
  State<PartyCard> createState() => _PartyCard();
}

class _PartyCard extends State<PartyCard> {
  @override
  Widget build(BuildContext context) {
    PartiesController pc = Get.put(PartiesController(Get.put(PartiesService())));

    return Material(
      child: GestureDetector(
        onTap: () async {
          if(widget.canOpen) {
            pc.setPartyDetails(widget.party!);
            Get.to(const PartyPreview());
          }
        },
        child: Card(
          color: widget.isMine ? Colors.amber : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: [
                  Text(widget.title),
                  Text(widget.date.toString()),
                  Text(widget.participants.toString()),
                  Text(widget.type),
                ],
              )
            )
          )
        )
      ),
    );
  }
}