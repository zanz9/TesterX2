import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/theme/provider.dart';
import 'package:testerx2/ui/ui.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isDark});
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = GetIt.I<AppRouter>();
    const primaryColor = Colors.orange;
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => ThemeSettings(isDark),
      builder: (context, child) {
        final themeSettings = Provider.of<ThemeSettings>(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TesterX',
          theme: lightTheme(primaryColor, theme),
          darkTheme: darkTheme(primaryColor, theme),
          themeMode: themeSettings.currentTheme,
          routerConfig: appRouter.config(),
        );
      },
    );
  }
}
