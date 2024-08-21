import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/history/history_model.dart';
import 'package:testerx2/repository/repository.dart';

class HistoryRepository {
  final db = FirebaseDatabase.instance;

  addHistory(String testId, TestModel test) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    int maxScoreTest = 0;
    int correct = 0;
    for (var e in test.tests) {
      correct += e.receive;
      maxScoreTest += e.maxScore;
    }
    var list = test.tests.map((e) => e.toJsonHistory()).toList();
    var pathHistory = await GetIt.I<StorageRepository>().uploadHistory(list);
    final history = HistoryModel(
      userId: uid!,
      testId: testId,
      timestamp: DateTime.now(),
      testLength: maxScoreTest,
      correct: correct,
      pathHistory: pathHistory,
    );
    db.ref('history').push().set(history.toJson());
  }
}
