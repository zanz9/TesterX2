import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:testerx2/presentation/main/widgets/tests_db.dart';
import 'package:testerx2/presentation/main/widgets/tests_local.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final LocalTxFiles localTxFiles = GetIt.I<LocalTxFiles>();
    final indicator = GlobalKey<RefreshIndicatorState>();
    return RefreshIndicator(
      key: indicator,
      onRefresh: () async {
        setState(() {});
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('TesterX'),
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
          if (localTxFiles.isUse) const TestsList(),
          if (!localTxFiles.isUse) const TestsDb(),
        ],
      ),
    );
  }
}
