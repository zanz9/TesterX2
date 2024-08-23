import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
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
                                  procent: true,
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
                                  procent: true,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
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

class ChartWidget extends StatelessWidget {
  const ChartWidget({
    super.key,
    required this.list,
    required this.underText,
    required this.procent,
  });

  final List list;
  final String underText;
  final bool procent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(horizontal: 3),
      child: AspectRatio(
        aspectRatio: 5 / 4,
        child: SizedBox(
          child: LineChart(
            duration: const Duration(milliseconds: 300),
            curve: Curves.linear,
            LineChartData(
              lineTouchData: const LineTouchData(
                enabled: true,
                touchSpotThreshold: 25,
                touchTooltipData: LineTouchTooltipData(),
              ),
              borderData: FlBorderData(
                show: false,
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Text(underText),
                  axisNameSize: 22,
                  sideTitles: const SideTitles(),
                ),
                topTitles: const AxisTitles(),
                leftTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
              ),
              gridData: const FlGridData(show: false),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  barWidth: 3,
                  curveSmoothness: .25,
                  gradient: LinearGradient(colors: [
                    Colors.black,
                    Colors.grey.shade700,
                    Colors.black,
                    Colors.grey.shade700,
                    Colors.black,
                  ]),
                  isStrokeCapRound: true,
                  dotData: const FlDotData(show: false),
                  spots: [
                    for (var (k, v) in list.indexed)
                      FlSpot(
                        k.toDouble(),
                        procent
                            ? (v.correct.toDouble() /
                                v.maxScore.toDouble() *
                                100)
                            : v.correct.toDouble(),
                      )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
