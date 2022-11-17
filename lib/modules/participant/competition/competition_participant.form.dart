import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/participant/competition/competition_participant.controller.dart';
import 'package:flutter_project/modules/participant/competition/competition_participant.state.dart';
import 'package:get/get.dart';

class ParticipantPage extends StatelessWidget {
  const ParticipantPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: _ParticipantForm()
    );
  }
}

class _ParticipantForm extends StatefulWidget {
  @override
  __ParticipantFormState createState() => __ParticipantFormState();
}

class __ParticipantFormState extends State<_ParticipantForm> {
  final _controller = Get.put(ParticipantController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _categorieController = TextEditingController();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Form(
        key: _key,
        autovalidateMode:
        _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Wrap(
            runSpacing: 18,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              _textFormField(CustomTextField(
                  labelText: "Categorie",
                  hintText: "url",
                  controller: _categorieController,
                  validatorType: "picture"
              )),
              ElevatedButton(
                onPressed: _controller.state is ParticipantLoading
                    ? () {}
                    : _onCoursButtonPressed,
                child: const Text('Join Competition'),
              ),
              if (_controller.state is ParticipantFailure)
                Text(
                  (_controller.state as ParticipantFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is ParticipantLoading)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        ),
      );
    });
  }

  dynamic _textFormField(CustomTextField textField) {
    return TextFormField(
        decoration: InputDecoration(
          labelText: textField.labelText,
          hintText: textField.hintText,
          filled: true,
          isDense: true,
        ),
        controller: textField.controller,
        validator: (value) => textField.getValidator(value)
    );
  }

  _onCoursButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.participant(_categorieController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

