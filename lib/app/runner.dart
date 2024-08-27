import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/app/application.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/core/router/router.dart';
import 'package:testerx2/core/utils/utils.dart';
import 'package:url_strategy/url_strategy.dart';

class Runner {
  Future<void> run() async {
    WidgetsFlutterBinding.ensureInitialized();
    await firebaseInit();
    await registerSingletons();
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

  registerSingletons() async {
    GetIt.I.registerSingleton<AppRouter>(AppRouter());

    SharedPreferences prefs = await SharedPreferences.getInstance();
    GetIt.I.registerSingleton<SharedPreferences>(prefs);

    GetIt.I.registerSingleton<AuthRepository>(AuthRepository());
    GetIt.I.registerSingleton<GroupRepository>(GroupRepository());
    GetIt.I.registerSingleton<StorageRepository>(StorageRepository());
    GetIt.I.registerSingleton<TestRepository>(TestRepository());
    GetIt.I.registerSingleton<HistoryRepository>(HistoryRepository());
    GetIt.I.registerSingleton<SortedByTestIdRepository>(
        SortedByTestIdRepository());
  }
}
