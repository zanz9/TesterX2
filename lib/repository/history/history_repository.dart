import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:testerx2/repository/repository.dart';

class HistoryRepository {
  final db = FirebaseDatabase.instance;

  Future<HistoryModel> addHistory(TestModel test) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    int maxScoreTest = 0;
    int correct = 0;
    List<Map<String, dynamic>> list = test.tests.map((e) {
      correct += e.receive;
      maxScoreTest += e.maxScore;
      return e.toJsonHistory();
    }).toList();
    String pathHistory = await GetIt.I<StorageRepository>().uploadHistory(list);
    final history = HistoryModel(
      userId: uid!,
      testId: test.id,
      timestamp: DateTime.now(),
      testLength: test.tests.length,
      correct: correct,
      maxScore: maxScoreTest,
      pathHistory: pathHistory,
    );
    var newHistory = db.ref('history/$uid').push();
    await newHistory.set(history.toJson());
    await GetIt.I<SortedByTestIdRepository>()
        .addSortedByTestId(test.id, correct, maxScoreTest, newHistory.key!);
    return history;
  }

  Future<List<HistoryModel>> getAllHistory(String uid) async {
    DataSnapshot data = await db
        .ref('history/$uid')
        .orderByChild('timestamp')
        .limitToLast(50)
        .get();
    List<HistoryModel> list = [];
    for (var element in ((data.value ?? {}) as Map).entries) {
      list.add(HistoryModel.fromJson(element.value as Map));
    }
    list.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return list;
  }

  Future<List<HistoryModel>> getAllHistoryByTestId(
      {required String uid, required String testId, int limit = 10}) async {
    DataSnapshot data = await db
        .ref('history/$uid')
        .orderByChild('testId')
        .equalTo(testId)
        .limitToLast(10)
        .get();
    List<HistoryModel> list = [];
    for (var element in ((data.value ?? {}) as Map).entries) {
      list.add(HistoryModel.fromJson(element.value as Map));
    }
    list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return list;
  }
}
