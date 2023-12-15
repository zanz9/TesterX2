import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testerx2/models/index.dart';
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
    QuerySnapshot<Map<String, dynamic>?> testData;
    if (isAdmin) {
      testData = await testsDB.orderBy('name', descending: false).get();
    } else {
      testData = await testsDB.where('group', isEqualTo: group[0]).get();
    }

    List tests = [];
    List<Future> futures = [];
    Future<void> getTest(test, tests) async {
      Map<String, dynamic> data = test.data();
      bool isExists = await StorageService().isFileExists(data['tx']);
      tests.add({
        'id': test.id,
        'name': data['name'],
        'group': data['group'],
        'isExists': isExists,
      });
    }

    for (var test in testData.docs) {
      futures.add(getTest(test, tests));
    }

    await Future.wait(futures);
    return tests;
  }

  Future<TX?> getTXDataByPath(String path) async {
    String? data = await StorageService().readFileFromStorage(path);
    if (data == null) {
      return null;
    }
    TX txData = TX.fromJson(jsonDecode(data));
    return txData;
  }

  Future<Map?> getTestById(String id) async {
    final test = await db.collection('tests').doc(id).get();
    final data = test.data();
    if (data == null) return null;

    String path = data['tx'];
    TX? txData = await getTXDataByPath(path);
    if (txData == null) return null;

    return {...data, 'txData': txData};
  }
}
