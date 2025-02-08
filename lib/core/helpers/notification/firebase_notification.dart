/*
// ignore_for_file: avoid_print

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:goalak_app/data/utils/api_paths.dart';
import 'package:goalak_app/data/utils/api_service.dart';
import 'notification_manger.dart';

String? fCMToken;
class FirebaseManager {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    fCMToken = await _firebaseMessaging.getToken();

    NotificationManager().initNotification();
    print('FCM Token: $fCMToken');

    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    print('Title is: ${message.notification?.title}');
    print('Body is: ${message.notification?.body}');
    print('Payload is: ${message.data}');

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
    final res = await ApiService.postApi(ApiPaths.fbToken, body: {'fbToken': fCMToken});
    print(res.data);
  }
}
*/
