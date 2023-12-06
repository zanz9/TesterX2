import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final db = FirebaseFirestore.instance;

  static bool isAuth() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<Map<String, dynamic>?> getUser() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final user = await db.collection('users').doc(uid).get();
    Map<String, dynamic>? userData = user.data();
    return userData;
  }

  setUser({Map<String, dynamic>? data}) async {
    data ??= {};
    final uid = FirebaseAuth.instance.currentUser?.uid;
    Map<String, dynamic> userData = await getUser() ?? {};

    Map<String, dynamic> newData = {...userData, ...data, "uid": uid};
    await db.collection("users").doc(uid).set(newData);
  }

  Future<bool> isAdmin() async {
    final user = await getUser();
    return user!['isAdmin'] ?? false;
  }

  static Future<void> logout() async => await FirebaseAuth.instance.signOut();
}
