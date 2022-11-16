import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder'),
      ),
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: Text('Placeholder'),
      )
    );
  }
}