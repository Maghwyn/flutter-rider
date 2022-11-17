import 'package:flutter/material.dart';
import 'package:flutter_project/models/party.dart';
import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';
import 'package:flutter_project/modules/parties/widget/parties_preview.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
      child: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            if(widget.canOpen) {
              pc.setPartyDetails(widget.party!);
              Get.to(const PartyPreview());
            }
          },
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
                              image: NetworkImage(widget.type == "1"
                                ? "https://resize.prod.docfr.doc-media.fr/rcrop/1200,678,center-middle/ext/eac4ff34/content/2022/7/3/30-recettes-faciles-pour-un-aperitif-reussi-96406b4a1dfb77e5.jpeg"
                                : "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F34%2F2022%2F04%2F19%2Ffamily-dinner-party-eating-getty-0422-2000.jpg&q=60"
                              ),
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
                          runAlignment: WrapAlignment.center,
                          spacing: 10,
                          children: [
                            Wrap(
                              direction: Axis.vertical,
                              spacing: 5,
                              children: [
                                Text(widget.title,
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text("- ${widget.type == "1" ? "Pre-Dinner" : "Dinner"}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                                Text("- ${DateFormat("yyyy-MM-dd").format(widget.date)}",
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: widget.isMine ? const Icon(Icons.chat, color: Colors.purple, size: 30) : null,
                    )
                  ]
                )
              ),
            )
          )
        ),
      )
    );
  }
}