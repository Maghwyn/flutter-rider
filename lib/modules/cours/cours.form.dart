import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/cours/cours.controller.dart';
import 'package:flutter_project/modules/cours/cours.state.dart';
import 'package:get/get.dart';

class CoursPage extends StatelessWidget {
  const CoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: _CoursForm()
    );
  }
}

class _CoursForm extends StatefulWidget {
  @override
  __CoursFormState createState() => __CoursFormState();
}

class __CoursFormState extends State<_CoursForm> {
  final _controller = Get.put(CoursController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _trainingController = TextEditingController();
  final _dateController = TextEditingController();
  final _durationController = TextEditingController();
  final _specialityController = TextEditingController();
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
                  labelText: "Training ground",
                  hintText: "example@gmail.com",
                  controller: _trainingController,
                  validatorType: "training"
              )),
              _textFormField(CustomTextField(
                  labelText: "Date and hours",
                  hintText: "dd/mm/yy:hh/mm",
                  controller: _dateController,
                  validatorType: "date_hours"
              )),
              _textFormField(CustomTextField(
                  labelText: "Duration",
                  hintText: "hh/mm",
                  controller: _durationController,
                  validatorType: "duration"
              )),
              _textFormField(CustomTextField(
                  labelText: "Speciality",
                  hintText: "example : dressage, show jumping, endurance",
                  controller: _specialityController,
                  validatorType: "speciality"
              )),
              ElevatedButton(
                onPressed: _controller.state is CoursLoading
                    ? () {}
                    : _onCoursButtonPressed,
                child: const Text('Create lesson'),
              ),
              if (_controller.state is CoursFailure)
                Text(
                  (_controller.state as CoursFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is CoursLoading)
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
      _controller.cours(_trainingController.text, _dateController.text,
          _durationController.text, _specialityController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
