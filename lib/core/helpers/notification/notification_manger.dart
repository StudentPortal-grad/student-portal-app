import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:student_portal/core/network/api_endpoints.dart';

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationIos = const DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationIos,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification
    );
  }

  Future<void> showNotification({
    required String title,
    required String description,
    String? sound,
    bool message = false,
    Map<String, dynamic>? payload,
    background = false,
  }) async {
    AndroidNotificationCategory? category;
    if(message) category = AndroidNotificationCategory.message;
    // if(!SettingsRepository.notification) return;
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'student_portal_channel_id',
      'student_portal_channel_name',
      priority: Priority.high,
      importance: Importance.max,
      category: category,
      groupKey: message ? title : null,
      icon: '@mipmap/launcher_icon',
      // styleInformation: await getStyleInfo(title, description, message, payload),
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: const DarwinNotificationDetails()
    );

    final notificationId = payload?['notificationId'];
    final id = int.tryParse(notificationId is String ? notificationId : '')
        ?? DateTime.now().millisecondsSinceEpoch ~/ 1000;

    await notificationsPlugin.show(
      id,
      title,
      description,
      notificationDetails,
      payload: jsonEncode(payload),
    );
  }

  void onSelectNotification(NotificationResponse response) async{
    final data = response.payload;
    debugPrint('DATA :: $data');
  }


  Future<StyleInformation?> getStyleInfo(title, description, bool message, Map<String, dynamic>? payload) async {
    if(message){
      return MessagingStyleInformation(
        Person(name: title),
        messages: [
          Message(
            description,
            DateTime.now(),
            Person(name: title),
          ),
        ],
      );
    }

    final image = Uri.tryParse('${ApiEndpoints.baseUrl}${payload?['image']}');
    if(image != null){
      try {
        final http.Response response = await http.get(image);
        return BigPictureStyleInformation(ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)));
      } on Exception catch (e) {
        debugPrint(e.toString());
        return null;
      }
    }
    return null;
  }
}
