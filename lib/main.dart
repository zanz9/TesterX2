import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/router/router.dart';
import 'package:testerx2/ui/theme/darkTheme.dart';
import 'package:testerx2/ui/theme/lightTheme.dart';

Future<void> main() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter = GetIt.I<AppRouter>();
    const primaryColor = Colors.orange;
    final theme = Theme.of(context);
    return MaterialApp.router(
      title: 'TesterX',
      theme: darkTheme(primaryColor, theme),
      routerConfig: appRouter.config(),
    );
  }
}
