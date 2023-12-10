import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final storage = FirebaseStorage.instance;

  Future<String?> readFileFromStorage(String fileUrl) async {
    try {
      final path = await storage.ref(fileUrl).getDownloadURL();
      final dio = Dio();
      final data = await dio.get(path);
      return data.data;
    } catch (e) {
      return null;
    }
  }
}
