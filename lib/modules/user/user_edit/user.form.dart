import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';

import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:flutter_project/modules/user/user_edit/user_edit.state.dart';
import 'package:get/get.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _editcontroller = Get.put(UserController(Get.put(UserService())));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _pictureController = TextEditingController();
  bool _autoValidate = false;

  final User _user = inject<User>();

  bool _lights = true;

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));
    _nameController.text = uc.user.name;
    _emailController.text = uc.user.email;
    _pictureController.text = uc.user.picture;

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
                labelText: "Name",
                hintText: "Jeane Dark",
                controller: _nameController,
                validatorType: "name")),
            _textFormField(CustomTextField(
                labelText: "Email",
                hintText: "example@gmail.com",
                controller: _emailController,
                validatorType: "email")),
            _textFormField(CustomTextField(
                labelText: "Phone number",
                hintText: "06 12 12 12 12",
                controller: _phoneController,
                validatorType: "phone_number")),
            _textFormField(CustomTextField(
                labelText: "Age",
                hintText: "19",
                controller: _ageController,
                validatorType: "age")),
            _textFormField(CustomTextField(
                labelText: "Picture link",
                hintText:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqqxEGfipGn_10dPwgJLe_LRCOWYgIKNEA3A&usqp=CAU",
                controller: _pictureController,
                validatorType: "picture")),
            SwitchListTile(
              title: const Text('Demi-Pensionnaire'),
              value: _lights,
              onChanged: (bool value) {
                setState(() {
                  _lights = value;
                });
              },
            ),
            ElevatedButton(
              // onPressed: _editcontroller.stateForm is UserFormLoading
              //     ? () {}
              //     : _onEditButtonPressed,
              onPressed: _onEditButtonPressed,
              child: const Text('Edit'),
            ),
            // if (_editcontroller.stateForm is UserFormFailure)
            //   Text(
            //     (_editcontroller.stateForm as UserFormFailure).error,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(color: Get.theme.errorColor),
            //   ),
            // if (_editcontroller.stateForm is UserFormLoading)
            //   const Center(
            //     child: CircularProgressIndicator(),
            //   )
          ],
        ),
      ),
    );
  }

  _onEditButtonPressed() {
    if (_key.currentState!.validate()) {
      _editcontroller.updateUser(User(
        name: _nameController.text,
        email: _emailController.text,
        picture: _pictureController.text,
        role: _user.role,
        createdAt: _user.createdAt,
        number: int.parse(_phoneController.text.replaceAll(RegExp(r' '), '')),
        age: int.parse(_ageController.text),
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
