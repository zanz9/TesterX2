import 'package:shared_preferences/shared_preferences.dart';

class LocalTxFiles {
  LocalTxFiles({required this.isUse});
  bool isUse;

  Future<void> setLocalTxFiles(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('useLocalTxFiles', value);
    isUse = value;
  }

  Future<bool> getLocalTxFiles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool localTxFiles = prefs.getBool('useLocalTxFiles') ?? false;
    return localTxFiles;
  }

  Future<void> deleteLocalTxFiles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('useLocalTxFiles');
  }
}
