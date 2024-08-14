import 'package:firebase_database/firebase_database.dart';
import 'package:testerx2/repository/repository.dart';

class GroupRepository {
  final db = FirebaseDatabase.instance;

  Future<List<GroupModel>> getAllGroup(
      {bool orderBy = false, int limit = 10}) async {
    DataSnapshot group;
    if (orderBy) {
      group =
          await db.ref('group').orderByChild('name').limitToFirst(limit).get();
    } else {
      group = await db.ref('group').get();
    }
    List<GroupModel> list = [];
    for (var element in (group.value as Map).entries) {
      list.add(GroupModel(name: element.value['name'], id: element.key));
    }
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  }

  Future<String?> getGroup(String id) async {
    final group = await db.ref('group/$id').get();
    return (group.value as Map)['name'];
  }

  Future<String?> getMyGroup() async {
    final user = await AuthRepository().getUser();
    if (user == null) return null;
    String? groupId = user.groupId;
    if (groupId == null) return null;
    final group = await db.ref('group/$groupId').get();
    return (group.value as Map)['name'];
  }

  Future<void> addGroup({required String name}) async {
    var data = {
      "name": name,
    };
    var newGroup = db.ref('group').push();
    await newGroup.set(data);
  }
}
