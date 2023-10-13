import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/ui.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // ignore: library_private_types_in_public_api
  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = GetIt.I<AppRouter>();
    const primaryColor = Colors.orange;
    final theme = Theme.of(context);
    return MaterialApp.router(
      title: 'TesterX',
      theme: lightTheme(primaryColor, theme),
      darkTheme: darkTheme(primaryColor, theme),
      themeMode: _themeMode,
      routerConfig: appRouter.config(),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  ThemeMode get theme => _themeMode;
}
