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
  bool groupNull = false;
  var w = Stopwatch()..start();
  @override
  void initState() {
    loaded = false;
    TestService().getAllTests(isAdmin: widget.allTests).then((value) {
      setState(() {
        if (value == null) {
          groupNull = true;
        } else {
          tests = value;
        }
        loaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (groupNull) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'Выберите группу в настройках',
            style: theme.textTheme.bodyLarge?.copyWith(fontSize: 24),
          ),
        ),
      );
    }

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
              if (test['isExists']) {
                context.router.push(
                  TestPreviewRoute(
                    testName: fileName,
                    testId: testId,
                  ),
                );
              }
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
