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
      bool isExists = await StorageService().isFileExists(data['tx']);
      tests.add({
        'id': documentSnapshot.id,
        'name': data['name'],
        'group': data['group'],
        'isExists': isExists,
      });
    }
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
