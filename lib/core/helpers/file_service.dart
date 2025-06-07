import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:student_portal/core/helpers/permission_manager.dart';

class FileService {


  /// Pick a file (PDF, DOCX, Images, Videos)
  static Future<File?> pickFile() async {
    if (!await PermissionManager.requestPickPermission()) {
      log("Storage permission denied");
      return null;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg', 'mp4', 'mov'],
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null; // No file selected
  }

  /// Pick an image
  static Future<File?> pickImage() async {
    if (!await PermissionManager.requestPickPermission()) {
      log("Storage permission denied");
      return null;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null && result.files.single.path != null) {
      return File(result.files.single.path!);
    }
    return null; // No file selected
  }

  static Future<List<File?>>? pickImages() async {
    if (!await PermissionManager.requestPickPermission()) {
      log("Storage permission denied");
      return [];
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);

    if (result != null && result.files.isNotEmpty) {
      return result.files.map((file) => File(file.path!)).toList();
    }
    return [];
  }

  static Future<List<File>> pickFiles() async {
    if (!await PermissionManager.requestPickPermission()) {
      log("Storage permission denied");
      return [];
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'png', 'jpg', 'jpeg'],
      // , 'mp4', 'mov'
      allowMultiple: true,
    );

    if (result != null) {
      return result.paths
          .where((path) => path != null)
          .map((path) => File(path!))
          .toList();
    }

    return []; // No files selected
  }
}
