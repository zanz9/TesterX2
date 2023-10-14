import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/main/widgets/tests_db.dart';
import 'package:testerx2/presentation/main/widgets/tests_local.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLocalFiles = false;
  @override
  void initState() {
    super.initState();
    getLocalTxFiles().then((value) {
      setState(() {
        isLocalFiles = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          var a = await getLocalTxFiles();
          setState(() {
            isLocalFiles = a;
          });
        },
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text('TesterX'),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            if (isLocalFiles) const TestsList(),
            if (!isLocalFiles) const TestsDb()
          ],
        ),
      ),
    );
  }
}
