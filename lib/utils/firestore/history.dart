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
    List<Future> futures = [];

    Future<void> getHistoryData(dataHistory, history) async {
      final data = dataHistory.data();
      final test = await db.collection('tests').doc(data['testId']).get();
      bool isExists = await StorageService().isFileExists(test.get('tx'));
      history.add({
        ...data,
        'isExists': isExists,
      });
    }

    for (var dataHistory in dataHistories.docs) {
      futures.add(getHistoryData(dataHistory, history));
    }
    await Future.wait(futures);
    return history;
  }
}
