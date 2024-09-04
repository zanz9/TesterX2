import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:testerx2/core/utils/utils.dart';
import 'package:testerx2/repository/repository.dart';

@Singleton()
class TestRepository {
  final db = FirebaseDatabase.instance;

  Future<TestModel> addTest(
      dynamic fileBytes, String name, String groupId) async {
    Object jsonData;
    if (kIsWeb) {
      jsonData = await Docx().convertToJson(fileBytes);
    } else {
      String path = fileBytes.path;
      jsonData = await Docx().convertToJson(path);
    }
    String url = await GetIt.I<StorageRepository>().uploadFile(jsonData);
    String uid = GetIt.I<AuthRepository>().authInstance.currentUser!.uid;
    TestModel test = TestModel(
      path: url,
      name: name,
      groupId: groupId,
      authorId: uid,
      createdAt: DateTime.now(),
    );
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
      test.author =
          (await GetIt.I<AuthRepository>().getUser(uid: test.authorId))!;
      list.add(test);
    }
    return list;
  }

  Future<List<TestModel>> getLastTests() async {
    DataSnapshot data =
        await db.ref('tests').orderByChild('createdAt').limitToLast(10).get();
    List<TestModel> list = [];
    for (var element in ((data.value ?? {}) as Map).entries) {
      TestModel test = TestModel.fromJson(element.value as Map, element.key);
      String groupName =
          await GetIt.I<GroupRepository>().getGroup(test.groupId);
      test.group = GroupModel(id: test.groupId, name: groupName);
      test.author =
          (await GetIt.I<AuthRepository>().getUser(uid: test.authorId))!;
      list.add(test);
    }
    return list;
  }

  Future<TestModel> getTestById(String id) async {
    var prefs = GetIt.I<SharedPreferences>();
    var text = prefs.getString('tests/$id');

    late TestModel test;
    if (text != null && await Cache.isNotExpired()) {
      test = TestModel.fromJson(jsonDecode(text) as Map, id);
    } else {
      DataSnapshot data = await db.ref('tests').child(id).get();
      test = TestModel.fromJson(data.value as Map, id);
      if (text == null || text != jsonEncode(test.toJson())) {
        await prefs.setString('tests/$id', jsonEncode(test.toJson()));
      }
    }
    var groupName = await GetIt.I<GroupRepository>().getGroup(test.groupId);
    test.group = GroupModel(id: test.groupId, name: groupName);
    test.author =
        (await GetIt.I<AuthRepository>().getUser(uid: test.authorId))!;
    return test;
  }
}
