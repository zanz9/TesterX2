import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:testerx2/core/di/init_di.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();
