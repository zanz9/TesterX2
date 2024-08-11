import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';
import 'package:testerx2/presentation/new_test/view/new_test_screen.dart';
import 'package:testerx2/ui/ui.dart';

@RoutePage()
class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
          const HomeSliverAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
          SliverList.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              var testName = 'Тест ${index + 1}';
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: OpenContainer(
                  transitionType: ContainerTransitionType.fadeThrough,
                  transitionDuration: const Duration(milliseconds: 350),
                  openBuilder: (context, _) => NewTestScreen(
                    testName: testName,
                  ),
                  openColor: theme.scaffoldBackgroundColor,
                  middleColor: theme.scaffoldBackgroundColor,
                  closedColor: theme.scaffoldBackgroundColor,
                  openShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  tappable: true,
                  closedElevation: 0,
                  closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  closedBuilder: (context, openContainer) => GestureDetector(
                    onTap: openContainer,
                    child: PrimaryListWidget(
                      text: testName,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
