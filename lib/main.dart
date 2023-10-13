import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/firebase_options.dart';
import 'package:testerx2/myapp.dart';
import 'package:testerx2/router/router.dart';

Future<void> main() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
