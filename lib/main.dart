import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/myapp.dart';
import 'package:testerx2/singletons.dart';
import 'package:testerx2/utils/shared_preferences/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  registerSingletons();

  var prefs = GetIt.I<SharedPreferences>();
  bool isDark = prefs.getBool('isDark') ?? false;
  bool isUseLocalTxFiles = prefs.getBool('useLocalTxFiles') ?? false;
  GetIt.I
      .registerSingleton<LocalTxFiles>(LocalTxFiles(isUse: isUseLocalTxFiles));
  runApp(MyApp(isDark: isDark));
}
