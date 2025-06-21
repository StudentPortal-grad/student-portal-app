import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../network/api_service.dart';
import '../../utils/service_locator.dart';
import 'notification_manger.dart';

String? fCMToken;

class FirebaseManager {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    fCMToken = await _firebaseMessaging.getToken();

    NotificationManager().initNotification();
    log('FCM Token: $fCMToken');
    initPushNotifications();
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();

    final title = message.data['title'] ?? '';
    final body = message.data['body'] ?? '';

    await NotificationManager().initNotification(); // ensure plugin initialized
    await NotificationManager().showNotification(
      title: title,
      description: body,
      payload: message.data,
      background: true,
    );
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    log('Title is: ${message.notification?.title}');
    log('Body is: ${message.notification?.body}');
    log('Payload is: ${message.data}');

    final title = message.data['title'] ?? '';
    final body = message.data['body'] ?? '';

    NotificationManager().showNotification(title: title, description: body, payload: message.data);
  }

  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  static void deleteToken() => _firebaseMessaging.deleteToken();


  static saveToken() async{
    final res = await getIt<ApiService>().post(endpoint: '', data: {'fbToken': fCMToken});
    log("Saving Token:: $res");
  }
}
