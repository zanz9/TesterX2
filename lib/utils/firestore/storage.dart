import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<bool> isFileExists(String fileUrl) async {
    try {
      await storage.ref(fileUrl).getDownloadURL();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> readFileFromStorage(String fileUrl) async {
    try {
      final ref = storage.ref(fileUrl);
      String path = await ref.getDownloadURL();
      final dio = Dio();
      final data = await dio.get(path);
      return data.data;
    } catch (e) {
      return null;
    }
  }
}
