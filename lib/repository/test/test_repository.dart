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

  Future<TestModel?> getTestById(String id) async {
    DataSnapshot data = await db.ref('tests').child(id).get();
    if (data.value == null) return null;
    TestModel test = TestModel.fromJson(data.value as Map, id);

    var groupName = await GetIt.I<GroupRepository>().getGroup(test.groupId);
    test.group = GroupModel(id: test.groupId, name: groupName);
    test.author =
        (await GetIt.I<AuthRepository>().getUser(uid: test.authorId))!;
    return test;
  }

  Future<void> deleteTest(TestModel test) async {
    await db.ref('tests').child(test.id).remove();
    await GetIt.I<SharedPreferences>().remove('tests/${test.id}');
  }

  Future<void> addUserToAccessList(String testId, String uid) async {
    var accessList =
        await db.ref('tests').child(testId).child('accessList').get();
    if (accessList.value == null) {
      await db.ref('tests').child(testId).child('accessList').set([uid]);
    } else {
      List<String> list = (accessList.value as List<dynamic>).cast<String>();
      await db
          .ref('tests')
          .child(testId)
          .child('accessList')
          .set([...list, uid]);
    }
  }

  Future<void> removeUserFromAccessList(String testId, String uid) async {
    await db.ref('tests').child(testId).child('accessList').child(uid).remove();
  }
}
