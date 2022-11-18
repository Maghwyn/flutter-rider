import 'package:flutter/material.dart';
import 'package:flutter_project/modules/parties/widget/parties_comment_form.dart';
import 'package:get/get.dart';

import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';

class PartyPreview extends StatelessWidget {
  const PartyPreview({super.key});

  @override
  Widget build(BuildContext context) {
    PartiesController pc = Get.put(PartiesController(Get.put(PartiesService())));

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: pc.partyCard,
            ),
            const Expanded(
              // flex: 10,
              child: PartyCommentForm()
            ),
            Expanded(
              flex: 3,
              child: Obx(
                    () => ListView(
                  children: pc.participantsComments,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}