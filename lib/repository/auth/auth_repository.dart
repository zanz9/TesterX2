import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final db = FirebaseFirestore.instance;
  final authInstance = FirebaseAuth.instance;

  Future<UserCredential> login({String? email, String? password}) async {
    UserCredential user;
    if (email == null || password == null) {
      user = await authInstance.signInAnonymously();
    } else {
      user = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
    }
    await setUser();
    return user;
  }

  Future<void> register(String email, String password) async {
    await authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async => await authInstance.signOut();

  bool isAuth() => authInstance.currentUser != null;

  Future<Map<String, dynamic>?> getUser() async {
    final uid = authInstance.currentUser?.uid;
    final user = await db.collection('users').doc(uid).get();
    Map<String, dynamic>? userData = user.data();
    return userData;
  }

  Future<void> setUser({Map<String, dynamic>? data}) async {
    data ??= {};
    final uid = authInstance.currentUser?.uid;
    Map<String, dynamic> userData = await getUser() ?? {};

    Map<String, dynamic> newData = {...userData, ...data, "uid": uid};
    await db.collection("users").doc(uid).set(newData);
  }

  Future<bool> isAdmin() async {
    final user = await getUser();
    return user!['isAdmin'] ?? false;
  }
}
