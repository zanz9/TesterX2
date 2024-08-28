import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:testerx2/repository/sorted_by_test_id/sorted_by_test_id_model.dart';

@Singleton()
class SortedByTestIdRepository {
  final db = FirebaseDatabase.instance;

  Future<void> addSortedByTestId(
      String testId, int correct, int maxScore, String historyId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    await db.ref('sorted_by_test_id').push().set(
          SortedByTestIdModel(
            userId: uid!,
            testId: testId,
            correct: correct,
            maxScore: maxScore,
            historyId: historyId,
            timestamp: DateTime.now(),
          ).toJson(),
        );
  }

  Future<List<SortedByTestIdModel>> getLastSortedByTestId(
      {required String testId, int limit = 10}) async {
    var data = await db
        .ref('sorted_by_test_id')
        .orderByChild('testId')
        .equalTo(testId)
        .limitToLast(limit)
        .get();
    List<SortedByTestIdModel> list = [];
    for (var element in ((data.value ?? {}) as Map).entries) {
      list.add(SortedByTestIdModel.fromJson(element.value as Map));
    }
    list.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return list;
  }
}
