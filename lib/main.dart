import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/myapp.dart';
import 'package:testerx2/singletons.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await registerSingletons();
  setPathUrlStrategy();
  SharedPreferences prefs = GetIt.I<SharedPreferences>();
  bool isDark = prefs.getBool('isDark') ?? false;
  bool isUseLocalTxFiles = prefs.getBool('useLocalTxFiles') ?? false;
  GetIt.I
      .registerSingleton<LocalTxFiles>(LocalTxFiles(isUse: isUseLocalTxFiles));
  runApp(MyApp(isDark: isDark));
}
