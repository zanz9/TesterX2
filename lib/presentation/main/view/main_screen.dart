import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/presentation/main/main.dart';

import 'package:testerx2/utils/firestore/index.dart';
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
  bool viewAllTestsFromDB = false;
  bool isAdmin = false;
  @override
  void initState() {
    AuthService().isAdmin().then((value) {
      if (value) {
        isAdmin = value;
      }
    });
    super.initState();
  }

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
            automaticallyImplyLeading: false,
            actions: [
              if (isAdmin)
                IconButton(
                  onPressed: () {
                    setState(() {
                      viewAllTestsFromDB = !viewAllTestsFromDB;
                    });
                    indicator.currentState!.show();
                  },
                  icon: Icon(Icons.admin_panel_settings,
                      color: viewAllTestsFromDB ? Colors.redAccent : null),
                ),
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
          if (!localTxFiles.isUse) TestsDb(allTests: viewAllTestsFromDB),
        ],
      ),
    );
  }
}
