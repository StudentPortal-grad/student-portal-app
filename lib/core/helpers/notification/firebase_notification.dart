import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../network/api_endpoints.dart';
import '../../network/api_service.dart';
import '../../utils/service_locator.dart';
import 'notification_manger.dart';

String? fCMToken;

class FirebaseManager {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    fCMToken = await _firebaseMessaging.getToken();

    log('FCM Token: $fCMToken');
    NotificationManager().initNotification();
    initPushNotifications();
  }

  /// Top-level background handler
  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    final title = message.data['title'] ?? message.notification?.title ?? '';
    final body = message.data['body'] ?? message.notification?.body ?? '';

    await NotificationManager().initNotification(); // ensure plugin initialized
    await NotificationManager().showNotification(
      title: title,
      description: body,
      payload: message.data,
      background: true,
    );
  }

  /// Called for foreground, background (onMessageOpenedApp), and terminated (getInitialMessage)
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log('FCM Message Received: ${message.toMap()}');

    final title = message.notification?.title ?? message.data['title'] ?? '';
    final body = message.notification?.body ?? message.data['body'] ?? '';

    NotificationManager().showNotification(
      title: title,
      description: body,
      payload: message.data,
    );
  }

  Future<void> initPushNotifications() async {
    // Set foreground presentation options for iOS
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle terminated state
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      handleMessage(initialMessage);
    }

    // Background (when tapped)
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Foreground
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  static Future<void> saveToken() async {
    if (fCMToken == null || fCMToken!.isEmpty) {
      log('❌ fCMToken is null or empty. Not sending request.');
      return;
    }
    try {
      final res = await getIt<ApiService>().post(
        endpoint: ApiEndpoints.updateNotificationToken,
        data: {'fcmToken': fCMToken, "platform": "mobile"},
      );
      log("Saving FCM Token:: $res");
    } on DioException catch (e) {
      log("❌ Failed to save token: ${e.response?.statusCode} ${e.response?.data}");
    }
  }

  static Future<void> removeToken() async {
    final res = await getIt<ApiService>().delete(
      endpoint: ApiEndpoints.updateNotificationToken,
    );
    _firebaseMessaging.deleteToken();
    log("Removing FCM Token:: $res");
  }
}
