import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/models/progress.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class TestFinishScreen extends StatelessWidget {
  const TestFinishScreen({
    super.key,
    required this.questions,
    required this.progressMap,
    required this.testName,
    required this.qBackup,
  });
  final List<Question> questions;
  final Map<int, Progress> progressMap;
  final String testName;
  final String qBackup;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final correct = (Map.from(progressMap)
          ..removeWhere((key, value) => !value.isRight))
        .length;
    final wrong = (Map.from(progressMap)
          ..removeWhere((key, value) => value.isRight))
        .length;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Результаты'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 56,
          child: ListContainer(
            bodyText: 'Перепройти тест',
            rightSide: Icon(Icons.replay, color: theme.hintColor),
            onTap: () {
              context.router.replace(TestPreviewRoute(
                testName: testName,
                file: null,
                qBackup: qBackup,
              ));
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: ListView(
          children: [
            FinishListContainer(
              child: Center(
                child: Text(
                  testName,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(height: 12),
            FinishListContainer(
              child: Column(
                children: [
                  Text('Всего ${questions.length} вопросов'),
                  Text('Правильных $correct'),
                  Text('Не правильных $wrong'),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class FinishListContainer extends StatelessWidget {
  const FinishListContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: child,
      ),
    );
  }
}
