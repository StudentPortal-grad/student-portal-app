import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'package:permission_handler/permission_handler.dart';

// import 'package:mime/mime.dart';
// import 'package:path/path.dart';
// import 'package:dio/dio.dart';

class FileService {
  // final Dio _dio = Dio();

  /// **Check and Request Storage Permissions**
  static Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      if (await Permission.photos.isGranted) return true;

      var status = await Permission.photos.request();
      return status.isGranted;
    }

    // iOS permissions are handled by the system automatically
    return true;
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.map((file) => File(file.path!)).toList();
    }
    return [];
  }


// /// Upload the selected file to the server
// Future<String?> uploadFile(File file) async {
//   String fileName = basename(file.path);
//   String? mimeType = lookupMimeType(file.path);
//
//   FormData formData = FormData.fromMap({
//     "file": await MultipartFile.fromFile(file.path,
//         filename: fileName,
//         contentType: mimeType != null ? DioMediaType.parse(mimeType) : null),
//   });
//
//   try {
//     Response response = await _dio.post(
//       "https://your-api.com/upload", // Replace with your API endpoint
//       data: formData,
//       options: Options(
//         headers: {
//           "Authorization": "Bearer YOUR_TOKEN"
//         }, // Add auth headers if needed
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       return response.data["file_url"]; // Return uploaded file URL
//     }
//   } catch (e) {
//     print("Upload failed: $e");
//   }
//   return null;
// }
}
