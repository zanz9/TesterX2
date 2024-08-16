import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class StorageRepository {
  uploadFile(File file) async {
    final storageRef = FirebaseStorage.instance.ref();
    var fileName = basename(file.path);
    var testsRef = storageRef.child('tests/$fileName.json');
    await testsRef.putFile(file);
  }
}
