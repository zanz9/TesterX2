import 'package:animations/animations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/presentation/new_home/new_home.dart';
import 'package:testerx2/presentation/new_test/view/new_test_screen.dart';

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
              return OpenContainer(
                transitionType: ContainerTransitionType.fadeThrough,
                transitionDuration: const Duration(milliseconds: 350),
                openBuilder: (context, _) => const NewTestScreen(),
                openColor: theme.scaffoldBackgroundColor,
                middleColor: theme.scaffoldBackgroundColor,
                closedColor: theme.scaffoldBackgroundColor,
                openShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tappable: true,
                closedElevation: 0,
                routeSettings: const RouteSettings(name: '/new_test'),
                useRootNavigator: true,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                closedBuilder: (context, openContainer) => GestureDetector(
                  onTap: openContainer,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    height: 54,
                    child: const Row(
                      children: [
                        Text(
                          'Название теста 54',
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.black,
                          size: 36,
                        ),
                      ],
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
