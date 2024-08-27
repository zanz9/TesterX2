import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static Future<bool> isNotExpired() async {
    SharedPreferences prefs = GetIt.I<SharedPreferences>();
    String expCacheKey = 'expCache';
    var now = DateTime.now();
    if (prefs.getString(expCacheKey) != null) {
      var exp = DateTime.parse(prefs.getString(expCacheKey)!);
      if (exp.isBefore(now)) {
        await prefs.setString(
            expCacheKey, now.add(const Duration(hours: 1)).toIso8601String());
      }
      return exp.isAfter(now);
    }
    await prefs.setString(
        expCacheKey, now.add(const Duration(hours: 1)).toIso8601String());
    return true;
  }
}
