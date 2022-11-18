import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';
import 'package:flutter_project/models/party_participant.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/admin/admin.controller.dart';
import 'package:flutter_project/modules/admin/admin.service.dart';
import 'package:get/get.dart';

import 'package:flutter_project/modules/parties/parties.controller.dart';
import 'package:flutter_project/modules/parties/parties.service.dart';

class PartyCommentForm extends StatelessWidget {
  const PartyCommentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: _PartyCommentForm(),
      )
    );
  }
}

class _PartyCommentForm extends StatefulWidget {
  @override
  __PartyCommentForm createState() => __PartyCommentForm();
}

class __PartyCommentForm extends State<_PartyCommentForm> {
  final _controller = Get.put(PartiesController(Get.put(PartiesService())));
  final _ac = Get.put(AdminController(Get.put(AdminService())));

  final User _user = inject<User>();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      autovalidateMode:
        _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 18,
          spacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[

            TextFormField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                isDense: true,
                labelText: "Comment",
                hintText: "I'm briging a bag of chips !"
              ),
              // validator: (value) => value!.isEmpty 
              //   ? null
              //   : "Message should contain at least 10 characters",
              keyboardType: TextInputType.text,
              controller: _commentController,
            ),

            ElevatedButton(
              onPressed: () => _onCommentButtonPressed(),
              child: const Text('Participate'),
            ),

            const Padding(padding: EdgeInsets.all(22)),

            if(_user.role[0] == "ADMIN" && _controller.party.status == "pending") (
              ElevatedButton(
                onPressed: () { _ac.validateParty(_controller.partyId, "accepted"); },
                child: const Text('Accept'),
              )
            ),

            if(_user.role[0] == "ADMIN" && _controller.party.status == "pending") (
              ElevatedButton(
                onPressed: () { _ac.validateParty(_controller.partyId, "rejected"); },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Reject'),
              )
            )
          ],
        ),
      ),
    );
  }

  _onCommentButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.addPartyParticipant(PartyParticipant(
        comment: _commentController.text,
      ), _controller.partyId);
      _commentController.clear();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}