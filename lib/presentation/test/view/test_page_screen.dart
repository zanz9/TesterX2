import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testerx2/models/question.dart';
import 'package:testerx2/presentation/test/cubit/answer_cubit.dart';
import 'package:testerx2/presentation/test/cubit/test_current_page_cubit.dart';
import 'package:testerx2/presentation/test/test.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class TestPageScreen extends StatelessWidget {
  const TestPageScreen({
    super.key,
    required this.questions,
    required this.testName,
    required this.testId,
  });
  final List<Question> questions;
  final String testName;
  final String? testId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    PageController pageController = PageController(initialPage: 0);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TestCurrentPageCubit(),
        ),
        BlocProvider(
          create: (context) => AnswerCubit(),
        ),
      ],
      child: BlocBuilder<TestCurrentPageCubit, int>(
        builder: (context, state) {
          return CallbackShortcuts(
            bindings: <ShortcutActivator, VoidCallback>{
              const SingleActivator(LogicalKeyboardKey.keyA): () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              const SingleActivator(LogicalKeyboardKey.keyD): () {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              }
            },
            child: Focus(
              autofocus: true,
              child: Scaffold(
                appBar: AppBar(
                  title: Text('${state + 1}/${questions.length}'),
                  centerTitle: true,
                  leading: IconButton(
                    icon: const Icon(Icons.exit_to_app),
                    onPressed: () {
                      final remained = questions.length -
                          context.read<AnswerCubit>().state.length;
                      final progressMap = context.read<AnswerCubit>().state;
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text(
                              'Вы действительно хотите закончить тест?'),
                          content: remained != 0
                              ? const Text('У вас есть не отвеченные вопросы')
                              : null,
                          actions: [
                            CupertinoDialogAction(
                              onPressed: () {
                                context.router.pop(context);
                                context.router.replace(TestFinishRoute(
                                  progressMap: progressMap,
                                  questions: questions,
                                  testName: testName,
                                  testId: testId,
                                ));
                              },
                              child: Text(
                                'Закончить',
                                style: TextStyle(color: theme.primaryColor),
                              ),
                            ),
                            CupertinoDialogAction(
                              onPressed: () {
                                context.router.pop(context);
                              },
                              child: Text(
                                'Отмена',
                                style: TextStyle(color: theme.primaryColor),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                endDrawer: BlocBuilder<AnswerCubit, Map<int, Progress>>(
                  builder: (context, state) {
                    return Drawer(
                      width: 100,
                      child: ListView.separated(
                        itemCount: questions.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final isRight = state[index]?.isRight;
                          Color? color = theme.textTheme.bodyMedium!.color;
                          if (isRight != null) {
                            if (isRight) {
                              color = Colors.greenAccent;
                            } else {
                              color = Colors.redAccent;
                            }
                          }
                          return ListTile(
                            title: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: color,
                              ),
                            ),
                            onTap: () {
                              pageController.animateToPage(
                                index,
                                duration: const Duration(seconds: 1),
                                curve: Curves.ease,
                              );
                            },
                          );
                        },
                      ),
                    );
                  },
                ),
                body: PageView.builder(
                  controller: pageController,
                  onPageChanged: (page) {
                    context.read<TestCurrentPageCubit>().changePage(page);
                  },
                  itemCount: questions.length,
                  itemBuilder: (context, index) => KeepAlivePage(
                    child: TestBody(
                      indexPage: index,
                      question: questions[index],
                      pageController: pageController,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class KeepAlivePage extends StatefulWidget {
  const KeepAlivePage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  // ignore: library_private_types_in_public_api
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
