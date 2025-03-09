import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/data/model/token_model/token_model.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final String _idKey = 'id';
  final String _accessTokenKey = 'access_token';
  final String _refreshTokenKey = 'refresh_token';
  final String _resetTokenKey = 'reset_token';
  final String _onboardingKey = 'onboarding_key';

  writeOnboardingData(bool isFirst) async {
    await storage.write(key: _onboardingKey, value: isFirst.toString());
  }

  Future<bool> readOnboardingData() async {
    bool isFirst = true;
    isFirst = (await storage.read(key: _onboardingKey) == "true" ||
        await storage.read(key: _onboardingKey) == null);
    return isFirst;
  }

  writeResetTokenData({
    required String resetToken,
  }) async {
    await storage.write(key: _resetTokenKey, value: resetToken);
  }

  deleteResetTokenData() async {
    await storage.delete(key: _resetTokenKey);
  }

  Future<String?> readResetTokenData() async =>
      await storage.read(key: _resetTokenKey);

  writeSecureData({
    String? id,
    String? accessToken,
    String? refreshToken,
  }) async {
    if (id != null) await storage.write(key: _idKey, value: id);
    if (accessToken != null) {
      await storage.write(key: _accessTokenKey, value: accessToken);
    }
    if (refreshToken != null) {
      await storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  writeSecureErrorResponse({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(key: _accessTokenKey, value: accessToken);
    await storage.write(key: _refreshTokenKey, value: refreshToken);
  }

  Future<TokenModel?> readSecureData() async {
    TokenModel tokenModel = TokenModel(
      id: await storage.read(key: _idKey),
      refreshToken: await storage.read(key: _refreshTokenKey),
      accessToken: await storage.read(key: _accessTokenKey),
    );
    return tokenModel;
  }

  Future<String?> readAccessToken() async => await storage.read(key: _accessTokenKey);

  deleteSecureData() async {
    await storage.delete(key: _idKey);
    await storage.delete(key: _accessTokenKey);
    await storage.delete(key: _refreshTokenKey);
    await storage.delete(key: _onboardingKey);
  }
}
