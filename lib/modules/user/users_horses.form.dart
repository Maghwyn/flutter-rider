import 'package:flutter/material.dart';

import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.state.dart';
import 'package:get/get.dart';

import '../auth/signup/signup.controller.dart';

class UserHorsesForm extends StatefulWidget {
  const UserHorsesForm({super.key});

  @override
  State<UserHorsesForm> createState() => _UserHorsesFormState();
}

class _UserHorsesFormState extends State<UserHorsesForm> {
  final _controller = Get.put(SignupController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _pictureController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _robeController = TextEditingController();
  final _raceController = TextEditingController();
  final _sexeController = TextEditingController();
  final bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController());

    return Form(
      key: _key,
      autovalidateMode:
          _autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 18,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            const Image(
              image: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'),
            ),
            _textFormField(CustomTextField(
                labelText: "Picture link",
                hintText:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqqxEGfipGn_10dPwgJLe_LRCOWYgIKNEA3A&usqp=CAU",
                controller: _pictureController,
                validatorType: "image")),
            _textFormField(CustomTextField(
                labelText: "Name",
                hintText: "Jeane Dark",
                controller: _nameController,
                validatorType: "name")),
            _textFormField(CustomTextField(
                labelText: "Age",
                hintText: "19",
                controller: _ageController,
                validatorType: "age")),
            _textFormField(CustomTextField(
                labelText: "Robe",
                hintText: "robe",
                controller: _robeController,
                validatorType: "robe")),
            _textFormField(CustomTextField(
                labelText: "Race",
                hintText: "race",
                controller: _raceController,
                validatorType: "race")),
            _textFormField(CustomTextField(
                labelText: "Sexe",
                hintText: "sexe",
                controller: _sexeController,
                validatorType: "sexe")),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}

dynamic _textFormField(CustomTextField textField) {
  return TextFormField(
    decoration: InputDecoration(
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
