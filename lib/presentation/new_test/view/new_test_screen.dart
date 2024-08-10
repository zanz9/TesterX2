import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class NewTestScreen extends StatelessWidget {
  const NewTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30),
              Text(
                'Название теста',
                style: TextStyle(fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
