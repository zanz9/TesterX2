import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/widgets/index.dart';
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

  @override
  void initState() {
    super.initState();
    getAllHistory();
  }

  getAllHistory() async {
    final historyList = await History().getAllHistory();
    setState(() {
      history = historyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final indicator = GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: indicator,
      onRefresh: () async {
        await getAllHistory();
      },
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
            itemCount: history.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final testName = history[index]['testName'];
              final testId = history[index]['testId'];
              final tx = history[index]['tx'];
              final correct = history[index]['correct'];
              final wrong = history[index]['wrong'];
              final length = history[index]['length'];
              final percent = correct / length * 100;
              return ListContainer(
                bodyText: history[index]['testName'],
                secondaryText: 'Пройдено на $percent%',
                rightSide: Icon(Icons.replay, color: theme.hintColor),
                onTap: () {
                  context.router.push(TestFinishRoute(
                    testName: testName,
                    qBackup: tx,
                    testId: testId,
                    correct: correct,
                    wrong: wrong,
                    length: length,
                  ));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
