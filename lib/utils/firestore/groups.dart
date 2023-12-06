import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testerx2/utils/firestore/auth.dart';

class GroupService {
  final db = FirebaseFirestore.instance;
  Future<Map<String, dynamic>> getGroups() async {
    final groups = await db.collection('groups').get();
    Map<String, dynamic> groupMap = {};
    for (var group in groups.docs) {
      groupMap[group.id] = group.data()['name'];
    }
    return groupMap; //* {ID:NAME, ID:NAME}
  }

  Future<List?> getUserGroup() async {
    final user = await AuthService().getUser();
    if (user == null) return null;
    String? groupId = user['group'];
    if (groupId == null) return null;
    final group = await db.collection('groups').doc(groupId).get();
    return [group.id, group.data()?['name']]; //* [ID, NAME]
  }

  setUserGroup(String groupId) async =>
      await AuthService().setUser(data: {"group": groupId});
}
