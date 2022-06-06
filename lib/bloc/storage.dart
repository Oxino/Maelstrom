import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uplodFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref().child('events/$fileName').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<ListResult> listFiles() async {
    ListResult results = await storage.ref('events').listAll();
    results.items.forEach((Reference ref) {
      print('Found file: $ref');
    });
    return results;
  }

  Future<String> getImagURL(String imageName) async {
    try {
      return await storage.ref('events').child('$imageName').getDownloadURL();
    } catch (e) {
      print("Storage error : $e");
      return "";
    }
  }
}
