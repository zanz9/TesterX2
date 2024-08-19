import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/new_test/new_test.dart';
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

    testPrev() {
      if (testIndex > 0) {
        setState(() {
          testIndex--;
        });
      }
    }

    testNext() {
      if (testIndex < tests.length - 1) {
        setState(() {
          testIndex++;
        });
      }
    }

    onSwipe(details) async {
      int direction = 3;
      if (details.velocity.pixelsPerSecond.dx > direction) testPrev();
      if (details.velocity.pixelsPerSecond.dx < -direction) testNext();
    }

    submit() {
      if (test.answered) return;
      if (test.answers.isEmpty) return;
      setState(() {
        test.answered = true;
        test.receive = (correctCount - test.answers.length);
        test.answers.map((el) {
          test.receive += test.body[el].score;
        }).toList();
        if (test.receive < 0) test.receive = 0;
      });
    }

    showMenuQuestionNumberList() {
      showCupertinoModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 350,
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                  ),
                  itemCount: tests.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
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
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300,
                            border: tests[index].answers.isNotEmpty
                                ? !tests[index].answered
                                    ? Border.all()
                                    : null
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                color: tests[index].answered
                                    ? tests[index].receive ==
                                            tests[index].maxScore
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
    }

    finishTestOrNot() {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('Вы уверены что хотите закончить тест?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Да'),
                onPressed: () {
                  tests.map((test) {
                    if (test.answers.isEmpty) return;
                    test.answered = true;
                    test.receive = (correctCount - test.answers.length);
                    test.answers.map((el) {
                      test.receive += test.body[el].score;
                    }).toList();
                    if (test.receive < 0) test.receive = 0;
                  }).toList();

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
    }

    return Scaffold(
      bottomNavigationBar: SizedBox(
          height: 82,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                    onPressed: testPrev, icon: const Icon(Icons.arrow_back))),
            Expanded(
                child: PrimaryButton(
                    margin: const EdgeInsets.all(10),
                    onTap: submit,
                    child: const Text('Ответить',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)))),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: IconButton(
                    onPressed: testNext, icon: const Icon(Icons.arrow_forward)))
          ])),
      body: GestureDetector(
        onPanEnd: onSwipe,
        child: SafeArea(
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
                            style: const TextStyle(fontSize: 18),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: showMenuQuestionNumberList,
                            icon: const Icon(Icons.menu_rounded),
                          ),
                          IconButton(
                            onPressed: finishTestOrNot,
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
      ),
    );
  }
}
