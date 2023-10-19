import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerx2/presentation/auth/models/user.dart';

class AuthService {
  final db = FirebaseFirestore.instance;
  void setUser(CustomUser customUser) {
    final user = {
      "uid": customUser.uid,
    };
    db.collection("users").doc(customUser.uid).set(user);
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
