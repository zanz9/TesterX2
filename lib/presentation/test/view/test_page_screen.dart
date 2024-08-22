import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testerx2/presentation/test/test.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class TestPageScreen extends StatelessWidget {
  const TestPageScreen({super.key, required this.testModel});
  final TestModel testModel;

  @override
  Widget build(BuildContext context) {
    final bloc = TestBloc()..add(OnTest(testModel: testModel));

    onSwipe(details) async {
      int direction = 3;
      if (details.velocity.pixelsPerSecond.dx > direction) {
        bloc.add(OnTestPrev());
      }
      if (details.velocity.pixelsPerSecond.dx < -direction) {
        bloc.add(OnTestNext());
      }
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
                  itemCount: testModel.tests.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => bloc.add(OnTestIndexSet(testIndex: index)),
                        child: Container(
                          height: 65,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300,
                            border: testModel.tests[index].answers.isNotEmpty
                                ? !testModel.tests[index].answered
                                    ? Border.all()
                                    : null
                                : null,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                color: testModel.tests[index].answered
                                    ? testModel.tests[index].receive ==
                                            testModel.tests[index].maxScore
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
          return FinishDialogWidget(bloc: bloc);
        },
      );
    }

    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
            height: 82,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: IconButton(
                          onPressed: () => bloc.add(OnTestPrev()),
                          icon: const Icon(Icons.arrow_back))),
                  Expanded(
                      child: PrimaryButton(
                          margin: const EdgeInsets.all(10),
                          onTap: () => bloc.add(OnTestSubmit()),
                          isLoading: false,
                          child: const Text('Ответить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)))),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: IconButton(
                          onPressed: () => bloc.add(OnTestNext()),
                          icon: const Icon(Icons.arrow_forward)))
                ])),
        body: CallbackShortcuts(
          bindings: <ShortcutActivator, VoidCallback>{
            const SingleActivator(LogicalKeyboardKey.keyA): () =>
                bloc.add(OnTestPrev()),
            const SingleActivator(LogicalKeyboardKey.keyD): () =>
                bloc.add(OnTestNext()),
          },
          child: Focus(
            autofocus: true,
            child: GestureDetector(
              onPanEnd: onSwipe,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    children: [
                      const SizedBox(height: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                BlocBuilder<TestBloc, TestState>(
                                  bloc: bloc,
                                  builder: (context, state) {
                                    if (state is TestLoaded) {
                                      return Text(
                                        '${state.textIndex + 1}/${testModel.tests.length}',
                                        style: const TextStyle(fontSize: 18),
                                      );
                                    }
                                    return const SizedBox();
                                  },
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
                          BlocBuilder<TestBloc, TestState>(
                            bloc: bloc,
                            builder: (context, state) {
                              if (state is TestLoaded) {
                                return Wrap(
                                  children: [
                                    ...state.test.title
                                        .split('<testerx_img>')
                                        .map((el) {
                                      if (el != el.split('TESTERX').last) {
                                        Uint8List u8 = base64Decode(
                                            el.split('TESTERX').last);
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
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          ),
                        ],
                      ),
                      const Divider(),
                      BlocBuilder<TestBloc, TestState>(
                        bloc: bloc,
                        builder: (context, state) {
                          if (state is TestLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.test.body.length,
                              itemBuilder: (context, index) {
                                return TestAnswerWidget(
                                  test: state.test,
                                  index: index,
                                  bloc: bloc,
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
