import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/widgets/index.dart';
import 'package:testerx2/utils/firestore/test.dart';

class TestsDb extends StatefulWidget {
  const TestsDb({
    super.key,
    required this.allTests,
  });
  final bool allTests;
  @override
  State<TestsDb> createState() => _TestsDbState();
}

class _TestsDbState extends State<TestsDb> {
  List tests = [];
  bool loaded = false;

  @override
  void initState() {
    loaded = false;
    TestService().getAllTests(isAdmin: widget.allTests).then((value) {
      setState(() {
        tests = value;
        loaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverList.separated(
      itemCount: loaded ? tests.length : 100,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (BuildContext context, int index) {
        if (loaded) {
          final test = tests[index];
          final fileName = test['name'].replaceFirst('.TX', '');
          final testId = test['id'];
          return ListContainer(
            bodyText: fileName,
            rightSide:
                Icon(Icons.arrow_forward_ios_rounded, color: theme.hintColor),
            onTap: () {
              context.router.push(
                TestPreviewRoute(
                  testName: fileName,
                  file: null,
                  qBackup: test['tx'],
                  testId: testId,
                ),
              );
            },
          );
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
    );
  }
}
