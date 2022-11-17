import 'package:flutter/material.dart';
import 'package:flutter_project/models/party_participant.dart';
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
                labelText: "Commentaire",
                hintText: "Write my message"
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
          ],
        ),
      ),
    );
  }

  _onCommentButtonPressed() {
    if (_key.currentState!.validate()) {
      print("test");
      _controller.addPartyParticipant(PartyParticipant(
        comment: _commentController.text,
      ), _controller.partyId);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}