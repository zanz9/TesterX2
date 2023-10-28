import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class History {
  final db = FirebaseFirestore.instance;
  Future<void> addToHistory(String testId, String testName) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data = {
      "uid": uid,
      "testId": testId,
      "testName": testName,
      "timestamp": Timestamp.now(),
    };
    db.collection('history').add(data);
  }

  Future<List> getAllHistory() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final data =
        await db.collection('history').where('uid', isEqualTo: uid).get();
    List history = [];
    for (var d in data.docs) {
      final da = d.data();
      final test = await db.collection('tests').doc(da['testId']).get();
      history.add({
        'testId': da['testId'],
        'testName': da['testName'],
        'timestamp': da['timestamp'],
        'tx': test.data()!['tx'],
      });
    }
    return history;
  }
}
