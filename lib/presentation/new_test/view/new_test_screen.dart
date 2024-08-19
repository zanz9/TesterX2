import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class NewTestScreen extends StatefulWidget {
  const NewTestScreen({super.key, required this.testModel});
  final TestModel testModel;

  @override
  State<NewTestScreen> createState() => _NewTestScreenState();
}

class _NewTestScreenState extends State<NewTestScreen> {
  int testIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<TestFileModel> tests = widget.testModel.tests;
    TestFileModel test = tests[testIndex];
    int correctCount = 0;
    for (var el in test.body) {
      if (el.score > 0) {
        correctCount++;
      }
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 82,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {
                  if (testIndex > 0) {
                    setState(() {
                      testIndex--;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            Expanded(
              child: PrimaryButton(
                margin: const EdgeInsets.all(10),
                onTap: () {
                  setState(() {
                    if (test.answered) return;
                    test.answered = true;
                    test.receive = (correctCount - test.answers.length);
                    test.answers.map((el) {
                      test.receive += test.body[el].score;
                    }).toList();
                  });
                },
                child: const Text(
                  'Ответить',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {
                  if (testIndex < tests.length - 1) {
                    setState(() {
                      testIndex++;
                    });
                  }
                },
                icon: const Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${testIndex + 1}/${tests.length}',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            showCupertinoModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 350,
                                  child: Scaffold(
                                    body: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 5,
                                        ),
                                        itemCount: tests.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Center(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  testIndex = index;
                                                });
                                              },
                                              child: Container(
                                                height: 65,
                                                width: 65,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.grey.shade300,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: tests[index]
                                                              .answered
                                                          ? tests[index]
                                                                      .receive ==
                                                                  tests[index]
                                                                      .maxScore
                                                              ? Colors.green
                                                              : Colors.red
                                                          : Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.menu_rounded),
                        ),
                        IconButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text(
                                      'Вы уверены что хотите закончить тест?'),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: const Text('Да'),
                                      onPressed: () {
                                        context.router.replaceAll([
                                          const NewHomeRoute(),
                                          NewTestFinishRoute(
                                            test: widget.testModel,
                                          ),
                                        ]);
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: const Text('Нет'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.exit_to_app_rounded),
                        ),
                      ],
                    ),
                  ),
                  ...test.title.split('<testerx_img>').map((el) {
                    if (el != el.split('TESTERX').last) {
                      Uint8List u8 = base64Decode(el.split('TESTERX').last);
                      return Image.memory(u8);
                    } else {
                      return Text(
                        el,
                        style: const TextStyle(
                          fontSize: 24,
                        ),
                      );
                    }
                  })
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: test.body.length,
                itemBuilder: (context, index) {
                  return TestAnswerWidget(
                    test: test,
                    index: index,
                    correctCount: correctCount,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestAnswerWidget extends StatefulWidget {
  const TestAnswerWidget({
    super.key,
    required this.test,
    required this.index,
    required this.correctCount,
  });

  final TestFileModel test;
  final int index;
  final int correctCount;

  @override
  State<TestAnswerWidget> createState() => _TestAnswerWidgetState();
}

class _TestAnswerWidgetState extends State<TestAnswerWidget> {
  @override
  Widget build(BuildContext context) {
    var answered = widget.test.answered;
    var isPressed = widget.test.answers.contains(widget.index);
    var isRight = widget.test.body[widget.index].score > 0;
    return GestureDetector(
      onTap: () {
        if (answered) return;
        setState(() {
          if (widget.test.answers.contains(widget.index)) {
            (widget.test.answers as List).remove(widget.index);
            return;
          }
          (widget.test.answers as List).add(widget.index);
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: [
            Icon(
              widget.test.answers.contains(widget.index)
                  ? Icons.circle
                  : Icons.circle_outlined,
              color: answered
                  ? isRight
                      ? Colors.green
                      : isPressed
                          ? Colors.red
                          : Colors.black
                  : Colors.black,
            ),
            const SizedBox(width: 6),
            ...widget.test.body[widget.index].text
                .split('<testerx_img>')
                .map((el) {
              if (el != el.split('TESTERX').last) {
                Uint8List u8 = base64Decode(el.split('TESTERX').last);
                return Image.memory(u8);
              } else {
                return Text(
                  el,
                  style: TextStyle(
                    fontSize: 18,
                    color: answered
                        ? isRight
                            ? Colors.green
                            : isPressed
                                ? Colors.red
                                : Colors.black
                        : Colors.black,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
