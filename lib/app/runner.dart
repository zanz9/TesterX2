import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/app/application.dart';
import 'package:testerx2/core/di/init_di.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/core/utils/utils.dart';
import 'package:url_strategy/url_strategy.dart';

class Runner {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await firebaseInit();

    await registerPrefs();
    configureDependencies();

    await initCache();

    setPathUrlStrategy();
    runApplication();
  }

  firebaseInit() async => await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);

  initCache() async => await Cache.isNotExpired();

  runApplication() {
    bool isDark = false;
    runApp(Application(isDark: isDark));
  }

  registerPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefs);
  }
}
