import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';

import 'core/helpers/notification/firebase_notification.dart';
import 'core/utils/app_local_storage.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'features/app/view/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(FirebaseManager.firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseManager().initNotifications();

  Bloc.observer = MyBlocObserver();
  setupServiceLocator();

  await Future.wait<void>([
    AppLocalStorage.init(),
    ScreenUtil.ensureScreenSize(),
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => const SPApp(),
    ),
  );
}
