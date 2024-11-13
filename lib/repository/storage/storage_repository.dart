import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:testerx2/repository/repository.dart';
import 'package:uuid/uuid.dart';

@Singleton()
class StorageRepository {
  Reference storageRef = FirebaseStorage.instance.ref();

  Future<String> uploadFile(Object data) async {
    String jsonData = jsonEncode(data);
    String base64String = base64.encode(utf8.encode(jsonData));
    String dataUrl = 'data:application/json;base64,$base64String';

    String fileName = const Uuid().v4();
    var path = 'tests/$fileName.json';
    Reference testsRef = storageRef.child(path);
    await testsRef.putString(dataUrl, format: PutStringFormat.dataUrl);
    return path;
  }

  Future<String> uploadHistory(Object data) async {
    String jsonData = jsonEncode(data);
    String base64String = base64.encode(utf8.encode(jsonData));
    String dataUrl = 'data:application/json;base64,$base64String';

    String fileName = const Uuid().v4();
    String path = 'history/$fileName.json';
    Reference historyRef = storageRef.child('history/$fileName.json');
    await historyRef.putString(dataUrl, format: PutStringFormat.dataUrl);
    return path;
  }

  Future<List<TestFileModel>> downloadTest(String path) async {
    var file = storageRef.child(path);
    var url = await file.getDownloadURL();
    var response = await http.get(Uri.parse(url));
    String content = utf8.decode(response.bodyBytes);
    List<dynamic> jsonContent = json.decode(content);
    List<TestFileModel> tests = jsonContent.map((el) {
      return TestFileModel.fromJson(el);
    }).toList();
    return tests;
  }

  Future<List<TestFileModel>> downloadHistory(String path) async {
    var file = storageRef.child(path);
    var url = await file.getDownloadURL();
    var response = await http.get(Uri.parse(url));
    String content = utf8.decode(response.bodyBytes);
    List<dynamic> jsonContent = json.decode(content);
    List<TestFileModel> tests = jsonContent.map((el) {
      return TestFileModel.fromJsonHistory(el);
    }).toList();
    return tests;
  }
}
