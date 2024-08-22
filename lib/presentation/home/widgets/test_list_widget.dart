import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/home/home.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/ui/ui.dart';

class TestListWidget extends StatelessWidget {
  const TestListWidget({
    super.key,
    required this.test,
  });

  final TestModel test;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return OpenContainer(
      openBuilder: (context, _) => TestPreview(
        test: test,
      ),
      closedBuilder: (context, openContainer) => GestureDetector(
        onTap: openContainer,
        child: PrimaryListWidget(
          text: test.name,
        ),
      ),
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(milliseconds: 350),
      openColor: theme.scaffoldBackgroundColor,
      middleColor: theme.scaffoldBackgroundColor,
      closedColor: theme.scaffoldBackgroundColor,
      openShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tappable: true,
      closedElevation: 0,
    );
  }
}
