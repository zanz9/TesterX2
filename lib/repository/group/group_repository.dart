import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';

@Singleton()
class GroupRepository {
  final db = FirebaseDatabase.instance;

  Future<List<GroupModel>> getAllGroup(
      {bool orderBy = false, int limit = 10}) async {
    DataSnapshot group;
    if (orderBy) {
      group =
          await db.ref('groups').orderByChild('name').limitToFirst(limit).get();
    } else {
      group = await db.ref('groups').get();
    }
    List<GroupModel> list = [];
    for (var element in (group.value as Map).entries) {
      list.add(GroupModel(name: element.value['name'], id: element.key));
    }
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  Future<String> getGroup(String id) async {
    var prefs = GetIt.I<SharedPreferences>();
    String? myGroupLocal = prefs.getString('groups/$id');
    if (myGroupLocal != null) return myGroupLocal;
    final group = await db.ref('groups/$id').get();
    await prefs.setString('groups/$id', (group.value as Map)['name']);
    return (group.value as Map)['name'];
  }

  Future<String?> getMyGroup({bool cache = true}) async {
    AuthModel? user = await GetIt.I<AuthRepository>().getUser(cache: cache);
    if (user == null) return null;
    String? groupId = user.groupId;
    if (groupId == null) return null;
    String? groupName = await getGroup(groupId);
    return groupName;
  }

  Future<void> addGroup({required String name}) async {
    var data = {
      "name": name,
    };
    var newGroup = db.ref('groups').push();
    await newGroup.set(data);
  }
}
