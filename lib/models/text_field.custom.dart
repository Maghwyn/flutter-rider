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
    "age": (String? value) => _ageValidator(value),
    "phone": (String? value) => _phoneValidator(value),
    "picture": (String? value) => _pictureValidator(value),
  };

  static String? _emailValidator(String? value) {
    if (value == null) {
      return 'Email is required.';
    }

    if (value.isEmpty) {
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

    if (value.isEmpty) {
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

    if (value.isEmpty) {
      return 'Name is required.';
    }

    if (value.length < 6) {
      return 'Name should be at least 6 characters';
    }

    return null;
  }

  static String? _ageValidator(String? value) {
    if (value == null) {
      return 'Age is required.';
    }

    if (value.isEmpty) {
      return 'Age is required.';
    }

    if (value.length > 3) {
      return 'Age format is invalid';
    }

    return null;
  }

  static String? _phoneValidator(String? value) {
    if (value == null) {
      return 'Phone number is required.';
    }

    if (value.isEmpty) {
      return 'Phone number is required.';
    }


    if (value.length < 10 && value.length > 15) {
      return 'Phone number format is invalid';
    }

    return null;
  }

  static String? _pictureValidator(String? value) {
    if (value == null) {
      return 'Picture is required.';
    }

    if (value.isEmpty) {
      return 'Picture is required.';
    }

    return null;
  }
}
