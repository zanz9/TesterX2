import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:testerx2/presentation/main/widgets/tests_db.dart';
import 'package:testerx2/presentation/main/widgets/tests_local.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final LocalTxFiles localTxFiles = GetIt.I<LocalTxFiles>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text('TesterX'),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          if (localTxFiles.isUse) const TestsList(),
          if (!localTxFiles.isUse) const TestsDb(),
        ],
      ),
    );
  }
}
