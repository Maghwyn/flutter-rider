import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/participant_competition.dart';
import 'package:flutter_project/modules/concours/competition.controller.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';

class CompetitionParticipationForm extends StatelessWidget {
  const CompetitionParticipationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      minimum: const EdgeInsets.all(16),
      child: _CompetitionParticipationForm(),
    ));
  }
}

class _CompetitionParticipationForm extends StatefulWidget {
  @override
  __CompetitionParticipationForm createState() =>
      __CompetitionParticipationForm();
}

class __CompetitionParticipationForm
    extends State<_CompetitionParticipationForm> {
  final _controller =
      Get.put(CompetitionsController(Get.put(CompetitionsService())));
  __CompetitionParticipationForm createState() =>
      __CompetitionParticipationForm();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
