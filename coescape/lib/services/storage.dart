import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:file_picker/file_picker.dart';

import '../utils/constants.dart';

class FirebaseStorageService {
  Future<bool> uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'pptx'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      String fileName = basename(file.path);
      Reference ref = FirebaseStorage.instance.ref().child('uploads/$fileName');
      await ref.putFile(file);
      infoToast('File saved successfully', gravity: ToastGravity.TOP);
      return false;
    } else {
      showToast('No file selected', gravity: ToastGravity.TOP);
      return true;
    }
  }

  Future<void> deleteFile(String filePath) async {
    Reference ref = FirebaseStorage.instance.ref(filePath);
    await ref.delete();
  }

  Future<void> updateFile(String filePath, File newFile) async {
    Reference ref = FirebaseStorage.instance.ref(filePath);
    await ref.putFile(newFile);
  }
}
