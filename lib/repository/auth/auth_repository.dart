import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/core/utils/utils.dart';
import 'package:testerx2/repository/auth/auth.dart';
import 'package:uuid/uuid.dart';

@Singleton()
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
    AuthModel? userData = await getUser();

    var token = const Uuid().v4();
    userData?.token = token;
    await prefs.setString('guardToken', token);

    await updateUser(data: userData);
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

  Future<AuthModel?> getUser({String? uid, bool cache = true}) async {
    AuthModel user;
    String? userFromStorage;
    uid ??= authInstance.currentUser?.uid;
    userFromStorage = prefs.getString('user/$uid');
    if (cache && userFromStorage != null && await Cache.isNotExpired()) {
      return AuthModel.fromJson(jsonDecode(userFromStorage) as Map);
    }
    DataSnapshot userData = await database.ref().child('users/$uid').get();
    if (userData.value == null) return null;
    user = AuthModel.fromJson(userData.value as Map);
    SharedPreferences newPrefs = await SharedPreferences.getInstance();
    var guardToken = newPrefs.getString('guardToken');
    if (guardToken != null) {
      if (guardToken != user.token) {
        logout();
      }
    }
    var userJson = jsonEncode(user.toJson());
    if (userFromStorage == null || userJson != userFromStorage) {
      await newPrefs.setString('user/$uid', userJson);
    }
    return user;
  }

  Future<void> updateUser({AuthModel? data, bool lazy = false}) async {
    data ??= AuthModel();
    await prefs.setString('user', jsonEncode(data.toJson()));
    String? uid = authInstance.currentUser?.uid;
    if (lazy) {
      database.ref('users/$uid').set(data.toJson());
    } else {
      await database.ref('users/$uid').set(data.toJson());
    }
  }

  Future<bool> isAdmin() async {
    final user = await getUser(cache: false);
    return user!.isAdmin;
  }

  Future<void> setUserDisplayName(String displayName) async {
    AuthModel? user = await getUser(cache: false);
    user?.displayName = displayName;
    await updateUser(data: user);
  }

  String? getMyUid() => authInstance.currentUser?.uid;

  Future<List<AuthModel>> getUsers() async {
    DataSnapshot users = await database.ref('users').get();
    if (users.value == null) {
      return [];
    }

    try {
      final data = users.value as Map<dynamic, dynamic>;

      return data.entries.map((e) {
        AuthModel user = AuthModel.fromJson(Map<String, dynamic>.from(e.value));
        user.uid = e.key;
        return user;
      }).toList();
    } catch (e) {
      print('Error parsing users: $e');
      return [];
    }
  }
}
