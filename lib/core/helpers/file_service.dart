import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';

import 'package:permission_handler/permission_handler.dart';

class FileService {
  /// **Check and Request Storage Permissions**
  static Future<bool> _requestPermission() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt < 30) {
      // Android 10 and below
      final storage = await Permission.storage.request();
      log('Storage permission: $storage');
      if (storage.isGranted) return true;
      if (storage.isPermanentlyDenied) await openAppSettings();
      return false;
    }

    // Android 11 and above: Request scoped media access
    final permissions = await Future.wait([
      Permission.photos.request(),
      Permission.videos.request(),
      Permission.audio.request(),
    ]);

    log('Media permissions: ${permissions.map((p) => p).toList()}');

    final granted = permissions.any((p) => p.isGranted);
    if (granted) return true;

    if (permissions.any((p) => p.isPermanentlyDenied)) {
      await openAppSettings();
    }
    return false;
  }

  /// Pick a file (PDF, DOCX, Images, Videos)
  static Future<File?> pickFile() async {
    if (!await _requestPermission()) {
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
    if (!await _requestPermission()) {
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
    if (!await _requestPermission()) {
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
    if (!await _requestPermission()) {
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
