import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:testerx2/repository/auth/auth_model.dart';

class AuthRepository {
  final db = FirebaseFirestore.instance;
  final authInstance = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<UserCredential> login({String? email, String? password}) async {
    UserCredential user;
    if (email == null || password == null) {
      user = await authInstance.signInAnonymously();
    } else {
      user = await authInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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

  Future<AuthModel?> getUser() async {
    final uid = authInstance.currentUser?.uid;
    final userData = await database.ref().child('users/$uid').get();
    final user = AuthModel.fromJson(userData.value as Map);
    return user;
  }

  Future<void> setUser({AuthModel? data}) async {
    data ??= AuthModel();
    final uid = authInstance.currentUser?.uid;
    await database.ref('users/$uid').set(data.toJson());
  }

  Future<bool> isAdmin() async {
    final user = await getUser();
    return user!.isAdmin;
  }
}
