import 'package:flutter/material.dart';

import 'package:flutter_project/models/text_field.custom.dart';
import 'package:flutter_project/modules/user/user.state.dart';
import 'package:get/get.dart';

import '../auth/signup/signup.controller.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _controller = Get.put(SignupController());

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _ageController = TextEditingController();
  final _pictureController = TextEditingController();
  final bool _autoValidate = false;

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
                  labelText: "Phone Number",
                  hintText: "06 12 12 12 12",
                  controller: _numberController,
                  validatorType: "phone")),
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
                  validatorType: "age")),
              if (_controller.state is UserFailure)
                Text(
                  (_controller.state as UserFailure).error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Get.theme.errorColor),
                ),
              if (_controller.state is UserFailure)
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
      obscureText: textField.validatorType == "password",
      keyboardType: textField.validatorType == "email"
          ? TextInputType.emailAddress
          : TextInputType.text,
      controller: textField.controller,
      validator: (value) => textField.getValidator(value),
    );
  }
}
