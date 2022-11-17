import 'package:flutter/material.dart';
import 'package:flutter_project/config/constants.dart';

class CustomTextField {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String validatorType;

  CustomTextField({
    required this.labelText,
    required this.hintText,
    required this.controller,
    required this.validatorType,
  });

  String? getValidator(String? value) {
    return validatorList[validatorType]!(value);
  }

  final validatorList = {
    "email": (String? value) => _emailValidator(value),
    "password": (String? value) => _passwordValidator(value),
    "name": (String? value) => _nameValidator(value),
  };

  static String? _emailValidator(String? value) {
    if (value == null) {
      return 'Email is required.';
    }

    if (emailFormat.hasMatch(value) == false) {
      return 'Email format is invalid';
    }

    return null;
  }

  static String? _passwordValidator(String? value) {
    if (value == null) {
      return 'Password is required.';
    }

    if (value.length < 8) {
      return 'Password should be at least 8 characters';
    }

    return null;
  }

  static String? _nameValidator(String? value) {
    if (value == null) {
      return 'Name is required.';
    }

    if (value.length < 6) {
      return 'Name should be at least 6 characters';
    }

    return null;
  }
}
