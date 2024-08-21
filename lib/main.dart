import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/myapp.dart';
import 'package:testerx2/singletons.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await registerSingletons();
  setPathUrlStrategy();
  bool isDark = false;
  runApp(MyApp(isDark: isDark));
}
