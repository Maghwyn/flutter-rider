import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('UserPage'),
        ),
        body: const SafeArea(
          minimum: EdgeInsets.all(16),
          child: Text('UserPage'),
        ));
  }
}
