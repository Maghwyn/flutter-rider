import 'package:flutter/material.dart';
import 'package:flutter_project/config/service_locator.dart';

import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/modules/user/user.controller.dart';
import 'package:flutter_project/modules/user/user.service.dart';
import 'package:get/get.dart';

class UserForm extends StatelessWidget {
  const UserForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: _UserFormState(),
      )
    );
  }
}

class _UserFormState extends StatefulWidget {
  const _UserFormState({super.key});

  @override
  State<_UserFormState> createState() => __UserFormState();
}

class __UserFormState extends State<_UserFormState> {
  final _editcontroller = Get.put(UserController(Get.put(UserService())));

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _pictureController = TextEditingController();
  bool _autoValidate = false;

  final User _user = inject<User>();

  @override
  Widget build(BuildContext context) {
    UserController uc = Get.put(UserController(Get.put(UserService())));
    _nameController.text = _user.name;
    _emailController.text = _user.email;
    _pictureController.text = _user.picture;
    _phoneController.text = _user.number ?? "";
    _ageController.text = _user.age ?? "";

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
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(uc.user.picture),
                  fit: BoxFit.cover,
                ),
                border: Border.all(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    width: 1.5),
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
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
                validatorType: "phone")),
            _textFormField(CustomTextField(
                labelText: "Age",
                hintText: "19",
                controller: _ageController,
                validatorType: "age")),
            _textFormField(CustomTextField(
                labelText: "Picture link",
                hintText: "https://example.com/image.png",
                controller: _pictureController,
                validatorType: "picture")),
            Obx(() => SwitchListTile(
              title: const Text('Demi-Pensionnaire'),
              value: uc.user.role[0] != "USER",
              onChanged: (bool value) {
                if(uc.user.role[0] != "ADMIN") {
                  uc.setDpRole(value);
                }
              },
            )),
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
        number: _phoneController.text,
        age: _ageController.text,
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
