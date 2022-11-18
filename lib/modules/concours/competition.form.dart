import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/competition.dart';
import 'package:flutter_project/modules/concours/competition.controller.dart';
import 'package:flutter_project/modules/concours/competition.service.dart';
import 'package:flutter_project/modules/concours/competition.state.dart';
import 'package:flutter_project/utils/time_format.dart';

class CompetitionForm extends StatelessWidget {
  const CompetitionForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.all(16),
          child: _CompetitionForm(),
        )
    );
  }
}

class _CompetitionForm extends StatefulWidget {
  @override
  __CompetitionFormState createState() => __CompetitionFormState();
}

class __CompetitionFormState extends State<_CompetitionForm> {
  final _controller = Get.put(CompetitionsController(Get.put(CompetitionsService())));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _adressController = TextEditingController();
  final _pictureController = TextEditingController();
  bool _autoValidate = false;


  static final DateTime _firstDate = DateTime.now();
  final DateTime _lastDate = DateTime(_firstDate.year, _firstDate.month + 3, _firstDate.day);

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
              controller: _nameController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Event name",
                filled: true,
                isDense: true,
              ),
            ),

            TextFormField(
              controller: _dateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Event date",
                filled: true,
                isDense: true,
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(FocusNode());

                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: _dateController.text.isEmpty
                      ? DateTime.now()
                      : DateTime.parse(_dateController.text),
                  firstDate: _firstDate,
                  lastDate: _lastDate,
                );

                if(date == null) {
                  return;
                }

                _dateController.text = DateFormat("yyyy-MM-dd").format(date);
              },
            ),

            TextFormField(
              controller: _timeController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Event hour",
                hintText: "00:00",
                filled: true,
                isDense: true,
              ),
              validator: (value) => value?.length == 5 ? null : "Hour must be of format XX:XX",
              inputFormatters: <TextInputFormatter>[
                TimeTextInputFormatter(hourMaxValue: 21, minuteMaxValue: 60),
              ],
            ),

            TextFormField(
              controller: _adressController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Event adress",
                filled: true,
                isDense: true,
              ),
            ),

            TextFormField(
              controller: _pictureController,
              keyboardType: const TextInputType.numberWithOptions(decimal: false),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.purple, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Event url picture",
                filled: true,
                isDense: true,
              ),
            ),

            ElevatedButton(
              onPressed: _controller.stateForm is CompetitionFormLoading
                  ? () {}
                  : _onCoursButtonPressed,
              child: const Text('Create competition'),
            ),
            if (_controller.stateForm is CompetitionFormFailure)
              Text(
                (_controller.stateForm as CompetitionFormFailure).error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Get.theme.errorColor),
              ),
            if (_controller.stateForm is CompetitionFormLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }

  _onCoursButtonPressed() {
    if (_key.currentState!.validate()) {
      _controller.addCompetition(Competition(
        name: _nameController.text,
        date: DateTime.parse("${_dateController.text} ${_timeController.text}Z"),
        adress: _adressController.text,
        picture: _pictureController.text,
      ));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
