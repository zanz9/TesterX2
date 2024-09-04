import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/core/theme/app_theme.dart';
import 'package:testerx2/core/theme/theme_settings.dart';

class Application extends StatelessWidget {
  const Application({super.key, required this.isDark, required this.talker});
  final bool isDark;
  final Talker talker;

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = GetIt.I<AppRouter>();
    return ChangeNotifierProvider(
      create: (context) => ThemeSettings(isDark),
      builder: (context, child) {
        final themeSettings = Provider.of<ThemeSettings>(context);
        return MaterialApp.router(
          title: 'TesterX',
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: themeSettings.currentTheme,
          routerConfig: appRouter.config(
            navigatorObservers: () => [TalkerRouteObserver(talker)],
          ),
        );
      },
    );
  }
}
