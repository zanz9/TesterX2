import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testerx2/utils/firestore/index.dart';

class TestService {
  final db = FirebaseFirestore.instance;

  Future<List> getAllTests({bool isAdmin = false}) async {
    final testsDB = db.collection('tests');
    final group = await GroupService().getUserGroup();
    QuerySnapshot<Map<String, dynamic>> data;
    if (isAdmin) {
      data = await testsDB.orderBy('name', descending: false).get();
    } else {
      data = await testsDB
          .where('group', isGreaterThanOrEqualTo: group![0])
          .orderBy('group')
          .orderBy('name', descending: false)
          .get();
    }

    List tests = [];
    for (QueryDocumentSnapshot documentSnapshot in data.docs) {
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      tests.add({
        'id': documentSnapshot.id,
        'name': data['name'],
        'group': data['group'],
        'tx': data['tx'],
      });
    }
    return tests;
  }
}
