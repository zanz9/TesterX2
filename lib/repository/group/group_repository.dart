import 'package:firebase_database/firebase_database.dart';

class GroupRepository {
  final db = FirebaseDatabase.instance;

  Future<void> setGroup({required String name}) async {
    var data = {
      "name": name,
    };
    var newGroup = db.ref('group').push();
    await newGroup.set(data);
  }

  Future<Object?> getAllGroup() async {
    final group = await db.ref('group').get();
    return group.value;
  }

  Future<String?> getGroup(String id) async {
    final group = await db.ref('group/$id').get();
    return (group.value as Map)['name'];
  }
}
