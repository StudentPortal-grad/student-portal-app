import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  /// Check if a permission is granted
  static Future<bool> isPermissionGranted(Permission permission) async {
    final status = await permission.status;
    return status.isGranted;
  }

  /// Request a specific permission
  static Future<bool> requestPermission(Permission permission) async {
    if (!await isPermissionGranted(permission)) {
      final status = await permission.request();
      return status.isGranted;
    }
    return true;
  }

  /// Request permission to pick media from storage
  static Future<bool> requestPickPermission() async {
    if (!Platform.isAndroid) return true;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = androidInfo.version.sdkInt;

    if (sdkInt < 30) {
      // Android 10 and below
      final status = await Permission.storage.request();
      log('Storage permission status: $status');

      if (status.isGranted) return true;
      if (status.isPermanentlyDenied) await openAppSettings();

      return false;
    } else {
      // Android 11+ scoped media access
      final results = await Future.wait([
        Permission.photos.request(),
        Permission.videos.request(),
        Permission.audio.request(),
      ]);

      log('Scoped media permissions: $results');

      final isAnyGranted = results.any((status) => status.isGranted);
      if (isAnyGranted) return true;

      if (results.any((status) => status.isPermanentlyDenied)) {
        await openAppSettings();
      }

      return false;
    }
  }
}
