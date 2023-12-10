import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testerx2/utils/firestore/index.dart';
import 'package:testerx2/utils/firestore/storage.dart';

class TestService {
  final db = FirebaseFirestore.instance;

  Future<List?> getAllTests({bool isAdmin = false}) async {
    final testsDB = db.collection('tests');
    final group = await GroupService().getUserGroup();
    if (group == null) {
      return null;
    }
    QuerySnapshot<Map<String, dynamic>?> data;
    if (isAdmin) {
      data = await testsDB.orderBy('name', descending: false).get();
    } else {
      data = await testsDB.where('group', isEqualTo: group[0]).get();
    }

    List tests = [];
    for (QueryDocumentSnapshot documentSnapshot in data.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      String? tx = await StorageService().readFileFromStorage(data['tx']);
      tests.add({
        'id': documentSnapshot.id,
        'name': data['name'],
        'group': data['group'],
        'tx': tx,
      });
    }
    return tests;
  }
}
