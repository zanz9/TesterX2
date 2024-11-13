import 'package:auto_route/auto_route.dart';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/presentation/test/test.dart';
import 'package:testerx2/presentation/widgets/widgets.dart';
import 'package:testerx2/repository/repository.dart';

@RoutePage()
class TestFinishScreen extends StatelessWidget {
  const TestFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = TestFinishBloc()..add(OnTestFinish());
    return BlocProvider.value(
      value: bloc,
      child: FloatingDraggableWidget(
        floatingWidget: ReloadIconWidget(bloc: bloc),
        dx: MediaQuery.of(context).size.width - 50 - 10,
        dy: 60,
        floatingWidgetHeight: 50,
        floatingWidgetWidth: 50,
        mainScreenWidget: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<TestFinishBloc, TestFinishState>(
                builder: (context, state) {
                  if (state is TestFinishLoaded) {
                    return ListView(
                      children: [
                        const SizedBox(height: 30),
                        Text(
                          'Название: ${bloc.testModel.name}',
                          style: const TextStyle(fontSize: 28),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Кол-во вопросов: ${bloc.testModel.tests.length}',
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Набранные баллы: ${bloc.correct}/${bloc.maxScoreTest}',
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
                                      state.myHistoryList != null
                                          ? Flexible(
                                              child: ChartWidget(
                                                list: state.myHistoryList!,
                                                underText:
                                                    GetIt.I<AuthRepository>()
                                                            .authInstance
                                                            .currentUser!
                                                            .displayName ??
                                                        'Пользователь',
                                                procent: false,
                                              ),
                                            )
                                          : const SizedBox(),
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
                          itemCount: bloc.testModel.tests.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 75,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemBuilder: (context, index) {
                            var test = bloc.testModel.tests[index];

                            var color = test.receive == test.maxScore
                                ? Colors.green.shade300
                                : test.answered
                                    ? Colors.red.shade200
                                    : Colors.transparent;
                            return GestureDetector(
                              onTap: () {
                                bloc.add(OnTestFinishCheck(
                                  testModel: bloc.testModel,
                                  testIndex: index,
                                ));
                              },
                              child: Container(
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
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
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
      ),
    );
  }
}

class ReloadIconWidget extends StatefulWidget {
  const ReloadIconWidget({
    super.key,
    required this.bloc,
  });

  final TestFinishBloc bloc;

  @override
  State<ReloadIconWidget> createState() => _ReloadIconWidgetState();
}

class _ReloadIconWidgetState extends State<ReloadIconWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: IconButton(
        splashColor: Colors.white,
        hoverColor: Colors.white,
        focusColor: Colors.white,
        highlightColor: Colors.white,
        color: Colors.black,
        style: IconButton.styleFrom(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
        ),
        onPressed: () {
          _controller.repeat();
          widget.bloc.add(OnTestFinishAgainPassTest());
        },
        icon: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}
