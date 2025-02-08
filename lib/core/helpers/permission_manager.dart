/*
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  ///method returns bool and can be used for checking either
  ///particular permission is granted or not
  static Future<bool> isPermissionGranted(Permission permission) async {
    return !(await permission.status.isDenied ||
        await permission.status.isRestricted);
  }

  ///A common method used for asking permissions
  static Future<bool> askForPermission(Permission permission) async {
    if (!await isPermissionGranted(permission)) {
      final status = await permission.request();
      return status.isGranted;
    }
    return true;
  }
}
*/
