import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:uuid/uuid.dart';

class StorageRepository {
  Future<String> uploadFile(File file) async {
    Reference storageRef = FirebaseStorage.instance.ref();
    String fileName = const Uuid().v4();
    Reference testsRef = storageRef.child('tests/$fileName.json');
    await testsRef.putFile(file);
    String url = await testsRef.getDownloadURL();
    return url;
  }

  Future<List<TestFileModel>> downloadTest(String url) async {
    var response = await http.get(Uri.parse(url));
    String content = utf8.decode(response.bodyBytes);
    List<dynamic> jsonContent = json.decode(content);
    List<TestFileModel> tests = jsonContent.map((el) {
      return TestFileModel.fromJson(el);
    }).toList();
    return tests;
  }
}
