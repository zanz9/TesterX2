import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
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

  Future<String> uploadHistory(Object data) async {
    String jsonData = jsonEncode(data);
    String dir = (await getTemporaryDirectory()).path;
    String fileName = const Uuid().v4();
    Directory dirHistory = Directory('$dir/history');
    if (!await dirHistory.exists()) {
      dirHistory.createSync(recursive: true);
    }
    File file = File('$dir/history/$fileName.json');
    await file.writeAsString(jsonData);

    Reference storageRef = FirebaseStorage.instance.ref();
    Reference historyRef = storageRef.child('history/$fileName.json');
    await historyRef.putFile(file);
    String url = await historyRef.getDownloadURL();
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

  Future<List<TestFileModel>> downloadHistory(String url) async {
    var response = await http.get(Uri.parse(url));
    String content = utf8.decode(response.bodyBytes);
    List<dynamic> jsonContent = json.decode(content);
    List<TestFileModel> tests = jsonContent.map((el) {
      return TestFileModel.fromJsonHistory(el);
    }).toList();
    return tests;
  }
}
