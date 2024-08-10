import 'package:flutter/material.dart';

class NewTestScreen extends StatelessWidget {
  const NewTestScreen({super.key, required this.testName});
  final String testName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Text(
                testName,
                style: const TextStyle(fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
