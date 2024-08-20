import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class NewTestFinishScreen extends StatelessWidget {
  const NewTestFinishScreen({super.key, required this.test});
  final TestModel test;

  @override
  Widget build(BuildContext context) {
    int maxScoreTest = 0;
    int correct = 0;
    for (var e in test.tests) {
      correct += e.receive;
      maxScoreTest += e.maxScore;
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Название: ${test.name}',
                style: const TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 20),
              Text(
                'Кол-во вопросов: ${test.tests.length}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              Text(
                'Набранные баллы: $correct/$maxScoreTest',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    Row(
                      children: [
                        for (var k in test.tests.asMap().keys)
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                '${k + 1}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        for (var v in test.tests)
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: v.receive == v.maxScore
                                  ? Colors.green
                                  : v.answered
                                      ? Colors.red
                                      : Colors.transparent,
                            ),
                            child: Center(
                              child: Text('${v.receive}/${v.maxScore}'),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.transparent,
        child: IconButton(
          color: Colors.black,
          style: IconButton.styleFrom(
            backgroundColor: Colors.white38,
            shadowColor: Colors.black,
          ),
          onPressed: () {},
          icon: const Icon(Icons.refresh_rounded),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: PrimaryButton(
            isLoading: false,
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'На главный экран',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
