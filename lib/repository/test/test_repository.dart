import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/utils/utils.dart';

class TestRepository {
  final db = FirebaseDatabase.instance;
  Future<TestModel> addTest(File testFile, String name, String groupId) async {
    String path = testFile.path;
    File jsonFile = await Docx().convertToJson(path);
    String url = await StorageRepository().uploadFile(jsonFile);
    TestModel test = TestModel(path: url, name: name, groupId: groupId);
    DatabaseReference newTest = db.ref('tests').push();
    await newTest.set(test.toJson());
    return test;
  }
}
