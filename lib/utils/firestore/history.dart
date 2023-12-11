import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testerx2/utils/firestore/storage.dart';

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
    final dataHistories = await db
        .collection('history')
        .where('uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .limit(10)
        .get();
    List history = [];
    for (var dataHistory in dataHistories.docs) {
      final data = dataHistory.data();
      final test = await db.collection('tests').doc(data['testId']).get();
      String path = test.get('tx');
      bool isExists = await StorageService().isFileExists(path);
      history.add({
        ...data,
        'tx': path,
        'isExists': isExists,
      });
    }
    return history;
  }
}
