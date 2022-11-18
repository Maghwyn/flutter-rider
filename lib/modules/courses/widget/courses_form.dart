import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import 'package:flutter_project/config/constants.dart';
import 'package:flutter_project/models/course.dart';
import 'package:flutter_project/modules/courses/courses.controller.dart';
import 'package:flutter_project/modules/courses/courses.service.dart';
import 'package:flutter_project/modules/courses/courses.state.dart';
import 'package:flutter_project/utils/time_format.dart';

class CourseForm extends StatelessWidget {
  const CourseForm({super.key});

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
        child: _CoursForm(),
      )
    );
  }
}

class _CoursForm extends StatefulWidget {
  @override
  __CoursFormState createState() => __CoursFormState();
}

class __CoursFormState extends State<_CoursForm> {
  final _controller = Get.put(CoursesController(Get.put(CoursesService())));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  bool _autoValidate = false;

  String _terrainController = "Arena";
  String _durationController = "0.5";
  String _specialityController = "Training";


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

            DropdownButtonFormField(
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
                labelText: "Terrain",
              ),
              dropdownColor: Colors.purple[100],
              value: _terrainController,
              onChanged: (String? newValue) {
                setState(() {
                  _terrainController = newValue!;
                });
              },
              items: courseTerrainItems,
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

            DropdownButtonFormField(
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
                labelText: "Duration",
                // fillColor: Colors.purple[100],
              ),
              dropdownColor: Colors.purple[100],
              value: _durationController,
              onChanged: (String? newValue) {
                setState(() {
                  _durationController = newValue!;
                });
              },
              items: courseDurationItems,
            ),

            DropdownButtonFormField(
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
                labelText: "Speciality",
              ),
              dropdownColor: Colors.purple[100],
              value: _specialityController,
              onChanged: (String? newValue) {
                setState(() {
                  _specialityController = newValue!;
                });
              },
              items: courseSpecialityItems,
            ),

            ElevatedButton(
              onPressed: _controller.stateForm is CourseFormLoading
                  ? () {}
                  : _onCoursButtonPressed,
              child: const Text('Create lesson'),
            ),
            if (_controller.stateForm is CourseFormFailure)
              Text(
                (_controller.stateForm as CourseFormFailure).error,
                textAlign: TextAlign.center,
                style: TextStyle(color: Get.theme.errorColor),
              ),
            if (_controller.stateForm is CourseFormLoading)
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
      _controller.addCourse(Course(
        terrain: _terrainController,
        date: DateTime.parse("${_dateController.text} ${_timeController.text}Z"),
        duration: _durationController,
        speciality: _specialityController,
        status: "pending",
      ));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}