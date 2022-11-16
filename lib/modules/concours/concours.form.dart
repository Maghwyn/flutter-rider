import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/concours/concours.controller.dart';
import 'package:flutter_project/modules/concours/concours.state.dart';
import 'package:get/get.dart';

class ConcoursPage extends StatelessWidget {
  const ConcoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: _ConcoursForm()
    );
  }
}

class _ConcoursForm extends StatefulWidget {
  @override
  __ConcoursFormState createState() => __ConcoursFormState();
}

class __ConcoursFormState extends State<_ConcoursForm> {
  final _controller = Get.put(ConcoursController());

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
                  validatorType: "training"
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
                  validatorType: "duration"
              )),
              _textFormField(CustomTextField(
                  labelText: "Picture",
                  hintText: "",
                  controller: _pictureController,
                  validatorType: "speciality"
              )),
              ElevatedButton(
                onPressed: _controller.state is ConcoursLoading
                    ? () {}
                    : _onCoursButtonPressed,
                child: const Text('Create lesson'),
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

  _onCoursButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.concours(_trainingController.text, _dateController.text,
          _durationController.text, _specialityController.text);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
