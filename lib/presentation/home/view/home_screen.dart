import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter.tabBar(
      routes: const [
        MainRoute(),
        HistoryRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
              selectedIconTheme: IconThemeData(color: theme.primaryColor),
              unselectedIconTheme:
                  theme.bottomNavigationBarTheme.unselectedIconTheme,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
              items: const [
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.play_arrow),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.history),
                ),
                BottomNavigationBarItem(
                  label: '',
                  icon: Icon(Icons.settings),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
