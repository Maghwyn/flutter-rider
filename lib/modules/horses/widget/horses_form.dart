import 'package:flutter/material.dart';
import 'package:flutter_project/models/horse.dart';

import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/horses/horses.controller.dart';
import 'package:flutter_project/modules/horses/horses.service.dart';
import 'package:get/get.dart';

class HorsesForm extends StatelessWidget {
  const HorsesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: _HorsesForm(),
      )
    );
  }
}

class _HorsesForm extends StatefulWidget {
  const _HorsesForm({super.key});

  @override
  State<_HorsesForm> createState() => __HorsesForm();
}

class __HorsesForm extends State<_HorsesForm> {
  final _controller = Get.put(HorsesController(Get.put(HorsesService())));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _pictureController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _robeController = TextEditingController();
  final _raceController = TextEditingController();
  final _sexeController = TextEditingController();
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
          alignment: WrapAlignment.center,
          children: <Widget>[
            _textFormField(CustomTextField(
                labelText: "Picture horse link",
                hintText:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqqxEGfipGn_10dPwgJLe_LRCOWYgIKNEA3A&usqp=CAU",
                controller: _pictureController,
                validatorType: "picture")),
            _textFormField(CustomTextField(
                labelText: "Name horse",
                hintText: "Jeane Dark",
                controller: _nameController,
                validatorType: "name")),
            _textFormField(CustomTextField(
                labelText: "Age horse",
                hintText: "19",
                controller: _ageController,
                validatorType: "age")),
            _textFormField(CustomTextField(
                labelText: "Robe horse",
                hintText: "robe",
                controller: _robeController,
                validatorType: "text")),
            _textFormField(CustomTextField(
                labelText: "Race horse",
                hintText: "race",
                controller: _raceController,
                validatorType: "text")),
            _textFormField(CustomTextField(
                labelText: "Sexe horse",
                hintText: "sexe",
                controller: _sexeController,
                validatorType: "text")),
            ElevatedButton(
              onPressed: _onEditButtonPressed,
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  _onEditButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.addHorse(Horse(
        name: _nameController.text,
        age: _ageController.text,
        picture: _pictureController.text,
        robe: _robeController.text,
        race: _raceController.text,
        sexe: _sexeController.text,
      ));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}

dynamic _textFormField(CustomTextField textField) {
  return TextFormField(
    decoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: textField.labelText,
      hintText: textField.hintText,
      filled: true,
      isDense: true,
    ),
    obscureText: textField.validatorType == "password",
    keyboardType: textField.validatorType == "email"
        ? TextInputType.emailAddress
        : TextInputType.text,
    controller: textField.controller,
    validator: (value) => textField.getValidator(value),
  );
}
