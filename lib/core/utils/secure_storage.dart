import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/data/model/token_model/token_model.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  final String idKey = 'id';
  final String accessTokenKey = 'access_token';
  final String refreshTokenKey = 'refresh_token';
  final String resetTokenKey = 'reset_token';
  final String onboardingKey = 'onboarding_key';

  writeOnboardingData(bool isFirst) async {
    await storage.write(key: onboardingKey, value: isFirst.toString());
  }

  Future<bool> readOnboardingData() async {
    bool isFirst = true;
    isFirst = (await storage.read(key: onboardingKey) == "true" ||
        await storage.read(key: onboardingKey) == null);
    return isFirst;
  }

  writeResetTokenData({
    required String resetToken,
  }) async {
    await storage.write(key: resetTokenKey, value: resetToken);
  }

  deleteResetTokenData() async {
    await storage.delete(key: resetTokenKey);
  }

  Future<String?> readResetTokenData() async =>
      await storage.read(key: resetTokenKey);

  writeSecureData({
    String? id,
    String? accessToken,
    String? refreshToken,
  }) async {
    if (id != null) await storage.write(key: idKey, value: id);
    if (accessToken != null) await storage.write(key: accessTokenKey, value: accessToken);
    if (refreshToken != null) await storage.write(key: refreshTokenKey, value: refreshToken);
  }

  writeSecureErrorResponse({
    required String accessToken,
    required String refreshToken,
  }) async {
    await storage.write(key: accessTokenKey, value: accessToken);
    await storage.write(key: refreshTokenKey, value: refreshToken);
  }

  Future<TokenModel?> readSecureData() async {
    TokenModel tokenModel = TokenModel(
      id: await storage.read(key: idKey),
      refreshToken: await storage.read(key: refreshTokenKey),
      accessToken: await storage.read(key: accessTokenKey),
    );
    return tokenModel;
  }

  deleteSecureData() async {
    await storage.delete(key: idKey);
    await storage.delete(key: accessTokenKey);
    await storage.delete(key: refreshTokenKey);
    // await storage.delete(key: onboardingKey);
  }
}
