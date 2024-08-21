import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:testerx2/utils/utils.dart';

class TestRepository {
  final db = FirebaseDatabase.instance;

  Future<TestModel> addTest(File testFile, String name, String groupId) async {
    String path = testFile.path;
    File jsonFile = await Docx().convertToJson(path);
    String url = await GetIt.I<StorageRepository>().uploadFile(jsonFile);
    TestModel test = TestModel(path: url, name: name, groupId: groupId);
    DatabaseReference newTest = db.ref('tests').push();
    await newTest.set(test.toJson());
    return test;
  }

  Future<List<TestModel>> getAllTestByGroupId(String groupId) async {
    DataSnapshot data =
        await db.ref('tests').orderByChild('groupId').equalTo(groupId).get();
    List<TestModel> list = [];
    for (var element in ((data.value ?? {}) as Map).entries) {
      TestModel test = TestModel.fromJson(element.value as Map, element.key);
      String groupName =
          await GetIt.I<GroupRepository>().getGroup(test.groupId);
      test.group = GroupModel(id: test.groupId, name: groupName);
      list.add(test);
    }
    return list;
  }

  Future<TestModel> getTestById(String id) async {
    var prefs = GetIt.I<SharedPreferences>();
    var text = prefs.getString('tests/$id');

    late TestModel test;
    if (text != null) {
      test = TestModel.fromJson(jsonDecode(text) as Map, id);
    } else {
      DataSnapshot data = await db.ref('tests').child(id).get();
      var test = TestModel.fromJson(data.value as Map, id);
      await prefs.setString('tests/$id', jsonEncode(test.toJson()));
      test = TestModel.fromJson(data.value as Map, id);
    }
    var groupName = await GetIt.I<GroupRepository>().getGroup(test.groupId);
    test.group = GroupModel(id: test.groupId, name: groupName);

    return test;
  }
}
