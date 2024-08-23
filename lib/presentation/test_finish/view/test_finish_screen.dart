import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/presentation/test_finish/test_finish.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class TestFinishScreen extends StatelessWidget {
  const TestFinishScreen({super.key, required this.testModel});
  final TestModel testModel;

  @override
  Widget build(BuildContext context) {
    int maxScoreTest = 0;
    int correct = 0;
    for (var e in testModel.tests) {
      correct += e.receive;
      maxScoreTest += e.maxScore;
    }

    var bloc = TestFinishBloc()..add(OnTestFinish(testId: testModel.id));
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                Text(
                  'Название: ${testModel.name}',
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(height: 20),
                Text(
                  'Кол-во вопросов: ${testModel.tests.length}',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                Text(
                  'Набранные баллы: $correct/$maxScoreTest',
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 20),
                BlocBuilder<TestFinishBloc, TestFinishState>(
                  builder: (context, state) {
                    if (state is TestFinishLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Последние 50:',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Flexible(
                                child: ChartWidget(
                                  list: state.otherHistoryList,
                                  underText: 'Общий',
                                  procent: false,
                                ),
                              ),
                              Flexible(
                                child: ChartWidget(
                                  list: state.myHistoryList,
                                  underText: GetIt.I<AuthRepository>()
                                          .authInstance
                                          .currentUser!
                                          .displayName ??
                                      'Пользователь',
                                  procent: false,
                                ),
                              ),
                            ],
                          ),
                          // const SizedBox(height: 10),
                          // Row(
                          //   children: [
                          //     Flexible(
                          //       child: ChartWidget(
                          //         list: state.myHistoryList,
                          //         underText: GetIt.I<AuthRepository>()
                          //                 .authInstance
                          //                 .currentUser!
                          //                 .displayName ??
                          //             'Пользователь',
                          //         procent: false,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: testModel.tests.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 75,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    var test = testModel.tests[index];

                    var color = test.receive == test.maxScore
                        ? Colors.green.shade300
                        : test.answered
                            ? Colors.red.shade200
                            : Colors.transparent;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12),
                        color: color,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${index + 1}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${test.receive}/${test.maxScore}',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   backgroundColor: Colors.transparent,
        //   child: IconButton(
        //     color: Colors.black,
        //     style: IconButton.styleFrom(
        //       backgroundColor: Colors.white38,
        //       shadowColor: Colors.black,
        //     ),
        //     onPressed: () {},
        //     icon: const Icon(Icons.refresh_rounded),
        //   ),
        // ),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: PrimaryButton(
              isLoading: false,
              onTap: () => Navigator.pop(context),
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
      ),
    );
  }
}
