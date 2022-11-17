import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/concours/competition.controller.dart';
import 'package:flutter_project/modules/concours/competition.state.dart';
import 'package:get/get.dart';

class CompetitionPage extends StatelessWidget {
  const CompetitionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: _CompetitionForm()
    );
  }
}

class _CompetitionForm extends StatefulWidget {
  @override
  __CompetitionFormState createState() => __CompetitionFormState();
}

class __CompetitionFormState extends State<_CompetitionForm> {
  final _controller = Get.put(CompetitionController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _adressController = TextEditingController();
  final _pictureController = TextEditingController();
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
                  labelText: "Name of the competition",
                  hintText: "",
                  controller: _nameController,
                  validatorType: "name"
              )),
              _textFormField(CustomTextField(
                  labelText: "Date and hours",
                  hintText: "dd/mm/yy:hh/mm",
                  controller: _dateController,
                  validatorType: "date_hours"
              )),
              _textFormField(CustomTextField(
                  labelText: "Adress",
                  hintText: "example : city,number street name",
                  controller: _adressController,
                  validatorType: "adress"
              )),
              _textFormField(CustomTextField(
                  labelText: "Picture",
                  hintText: "url",
                  controller: _pictureController,
                  validatorType: "picture"
              )),
              ElevatedButton(
                onPressed: _controller.state is ConcoursLoading
                    ? () {}
                    : _onConcoursButtonPressed,
                child: const Text('Create Competition'),
              ),
              if (_controller.state is ConcoursFailure)
                Text(
                  (_controller.state as ConcoursFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is ConcoursLoading)
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

  _onConcoursButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.concours(_nameController.text, _dateController.text,
          _adressController.text, _pictureController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
