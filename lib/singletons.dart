import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/router/router.dart';

registerSingletons() async {
  GetIt.I.registerSingleton<AppRouter>(AppRouter());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<AuthRepository>(AuthRepository());
  GetIt.I.registerSingleton<GroupRepository>(GroupRepository());
  GetIt.I.registerSingleton<StorageRepository>(StorageRepository());
  GetIt.I.registerSingleton<TestRepository>(TestRepository());
  GetIt.I.registerSingleton<HistoryRepository>(HistoryRepository());
  GetIt.I
      .registerSingleton<SortedByTestIdRepository>(SortedByTestIdRepository());
}
