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

  getAllHistory() async {
    final historyList = await History().getAllHistory();
    setState(() {
      history = historyList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    getAllHistory();
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('История'),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverList.separated(
              itemCount: history.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final testName = history[index]['testName'];
                final testId = history[index]['testId'];
                final tx = history[index]['tx'];
                return ListContainer(
                  bodyText: history[index]['testName'],
                  secondaryText: 'Пройдено на 100%',
                  rightSide: Icon(Icons.replay, color: theme.hintColor),
                  onTap: () {
                    context.router.push(TestPreviewRoute(
                      testName: testName,
                      file: null,
                      qBackup: tx,
                      testId: testId,
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
