import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';
import 'package:testerx2/utils/firestore/history.dart';

@RoutePage()
class HistoryScreen extends StatefulWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List history = [];
  bool loaded = false;
  @override
  void initState() {
    super.initState();
    getAllHistory();
  }

  Future<void> getAllHistory() async {
    final historyList = await History().getAllHistory();
    setState(() {
      history = historyList;
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final indicator = GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: indicator,
      onRefresh: getAllHistory,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('История'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                onPressed: () {
                  indicator.currentState!.show();
                },
                icon: const Icon(Icons.refresh),
              )
            ],
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList.separated(
            itemCount: loaded ? history.length : 100,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              if (loaded) {
                final isExists = history[index]['isExists'];
                if (isExists) {
                  final data = history[index];
                  final testName = data['testName'];
                  final testId = data['testId'];
                  final correct = data['correct'];
                  final wrong = data['wrong'];
                  final length = data['length'];
                  final percent = correct / length * 100;
                  final path = data['tx'];
                  return ListContainer(
                    bodyText: testName,
                    secondaryText: 'Пройдено на $percent%',
                    rightSide: Icon(Icons.replay, color: theme.hintColor),
                    onTap: () {
                      context.router.push(TestFinishRoute(
                        testName: testName,
                        testId: testId,
                        correct: correct,
                        wrong: wrong,
                        length: length,
                        path: path,
                      ));
                    },
                  );
                }
                return null;
              }
              return Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: theme.shadowColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
