import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final db = FirebaseFirestore.instance;

  static bool isAuth() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> setUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final user = await db.collection('users').doc(uid).get();
    if (user.data() == null) {
      db.collection("users").doc(uid).set({"uid": uid});
      return;
    }
    user.data()?.addAll({"uid": uid});
    db.collection("users").doc(uid).set(user.data()!);
  }

  Future<Map<String, dynamic>> getGroups() async {
    final groups = await db.collection('groups').get();
    Map<String, dynamic> groupMap = {};
    for (var group in groups.docs) {
      groupMap[group.id] = group.data()['name'];
    }
    return groupMap;
  }

  Future<String?> getUserGroup() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data =
        await db.collection('users').where("uid", isEqualTo: uid).get();
    String? groupId = data.docs.first.data()['group'];
    if (groupId == null) return null;
    final group = await db.collection('groups').doc(groupId).get();
    return group.data()?['name'];
  }

  void setUserGroup(String groupId) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final user = {
      "uid": uid,
      "group": groupId,
    };
    db.collection("users").doc(uid).set(user);
  }

  Future<bool> isAdmin() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final user = await db.collection("users").doc(uid).get();
    return user.data()!['isAdmin'] ?? false;
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
