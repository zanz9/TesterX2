import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
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
}
