import 'dart:developer';

import '../utils/app_local_storage.dart';
import '../../features/auth/data/model/user_model/user.dart';
import '../utils/secure_storage.dart';
import '../utils/service_locator.dart';

class UserRepository {
  static User? get user => _user ?? _getUser();
  static User? _user;
  static const String _userKey = "user";

  static Future<void> setUser(User? user) async {
    log("saving user: ${user?.toJson()}");
    if (user == null) {
      return;
    }
    _user = user;
    await AppLocalStorage.saveMap(_userKey, user.toJson());
  }

  static Future<void> removeUser() async {
    _user = null;
    await AppLocalStorage.removeData(_userKey);
    await getIt<SecureStorage>().deleteSecureData();
  }

  static User? _getUser() {
    final Map<String, dynamic>? userJson = AppLocalStorage.getMap(_userKey);
    if (userJson != null) {
      _user = User.fromJson(userJson);
    } else {
      _user = null;
    }
    return _user;
  }
}
