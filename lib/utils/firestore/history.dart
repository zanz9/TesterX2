import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History {
  final db = FirebaseFirestore.instance;
  Future<void> addToHistory(
    String testId,
    String testName,
    int correct,
    int wrong,
    int length,
  ) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data = {
      "uid": uid,
      "testId": testId,
      "testName": testName,
      "correct": correct,
      "wrong": wrong,
      "length": length,
      "timestamp": Timestamp.now(),
    };
    db.collection('history').add(data);
  }

  Future<List> getAllHistory() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data = await db
        .collection('history')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .get();
    List history = [];
    for (var d in data.docs) {
      final da = d.data();
      final test = await db.collection('tests').doc(da['testId']).get();
      history.add({
        'testId': da['testId'],
        'testName': da['testName'],
        'timestamp': da['timestamp'],
        'correct': da['correct'],
        'wrong': da['wrong'],
        'length': da['length'],
        'tx': test.data()!['tx'],
      });
    }
    return history;
  }
}
