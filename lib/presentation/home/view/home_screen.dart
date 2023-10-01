import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:testerx2/router/router.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        // Check the sizing information here and return your UI
        if (sizingInformation.deviceScreenType == DeviceScreenType.desktop) {
          return Container(color: Colors.blue);
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.tablet) {
          return Container(color: Colors.red);
        }

        if (sizingInformation.deviceScreenType == DeviceScreenType.watch) {
          return Container(color: Colors.yellow);
        }

        return AutoTabsRouter.tabBar(
          routes: const [
            MainRoute(),
            HistoryRoute(),
            SettingsRoute(),
          ],
          builder: (context, child, _) {
            final tabsRouter = AutoTabsRouter.of(context);
            return Scaffold(
              body: child,
              bottomNavigationBar: Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  selectedIconTheme: IconThemeData(color: theme.primaryColor),
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
      },
    );
  }
}
