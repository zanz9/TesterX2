import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/models/index.dart';
import 'package:testerx2/presentation/test/models/progress.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';
import 'package:testerx2/utils/utils.dart';

@RoutePage()
class TestFinishScreen extends StatelessWidget {
  const TestFinishScreen({
    super.key,
    required this.testName,
    required this.qBackup,
    required this.testId,
    this.questions,
    this.progressMap,
    this.correct,
    this.wrong,
    this.length,
  });
  final List<Question>? questions;
  final Map<int, Progress>? progressMap;
  final int? correct, wrong, length;
  final String testName, qBackup, testId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    int qCorrect, qWrong, qLength;
    if (questions != null && progressMap != null) {
      qCorrect = (Map.from(progressMap!)
            ..removeWhere((key, value) => !value.isRight))
          .length;
      qWrong = (Map.from(progressMap!)
            ..removeWhere((key, value) => value.isRight))
          .length;
      qLength = questions!.length;
      History().addToHistory(testId, testName, qCorrect, qWrong, qLength);
    } else {
      qCorrect = correct!;
      qWrong = wrong!;
      qLength = length!;
    }

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
                testId: testId,
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
                  Text('Всего $qLength вопросов'),
                  Text('Правильных $qCorrect'),
                  Text('Не правильных $qWrong'),
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
