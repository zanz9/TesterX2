import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/auth/auth_model.dart';
import 'package:testerx2/utils/utils.dart';

class AuthRepository {
  final authInstance = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  SharedPreferences prefs = GetIt.I<SharedPreferences>();

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
    await updateUser(data: await getUser());
    return user;
  }

  Future<void> register(String email, String password) async {
    await authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> resetPassword(String email) async {
    await authInstance.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await prefs.clear();
    await authInstance.signOut();
  }

  bool isAuth() => authInstance.currentUser != null;

  Future<AuthModel?> getUser() async {
    AuthModel user;
    String? displayName = authInstance.currentUser?.displayName;
    String? userFromStorage = prefs.getString('user');
    if (userFromStorage != null && await Cache.isNotExpired()) {
      user = AuthModel.fromJson(
        jsonDecode(prefs.getString('user')!) as Map,
        displayName,
      );
      return user;
    }

    String? uid = authInstance.currentUser?.uid;
    DataSnapshot userData = await database.ref().child('users/$uid').get();
    if (userData.value == null) return null;
    user = AuthModel.fromJson(
      userData.value as Map,
      displayName,
    );
    var userJson = jsonEncode(user.toJson());
    if (userFromStorage == null || userJson != userFromStorage) {
      await prefs.setString('user', userJson);
    }
    return user;
  }

  Future<void> updateUser({AuthModel? data, bool lazy = false}) async {
    data ??= AuthModel();
    await prefs.setString('user', jsonEncode(data.toJson()));
    await getUser();
    String? uid = authInstance.currentUser?.uid;
    if (lazy) {
      database.ref('users/$uid').set(data.toJson());
    } else {
      await database.ref('users/$uid').set(data.toJson());
    }
  }

  Future<bool> isAdmin() async {
    final user = await getUser();
    return user!.isAdmin;
  }

  Future<void> setUserDisplayName(String displayName) async {
    await authInstance.currentUser!.updateDisplayName(displayName);
  }
}
