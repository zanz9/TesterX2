import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/models/progress.dart';

@RoutePage()
class TestFinishScreen extends StatelessWidget {
  const TestFinishScreen({
    super.key,
    required this.questions,
    required this.progressMap,
  });
  final List<Question> questions;
  final Map<int, Progress> progressMap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Center(
                  child: Text('question.title![0]'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
