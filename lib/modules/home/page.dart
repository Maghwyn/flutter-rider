import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: Center(
          child: Text("Welcome !", 
            style: TextStyle(fontSize: 50)
            )
        ),
      )
    );
  }
}