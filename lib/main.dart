import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_preview/device_preview.dart';
import 'core/theming/colors.dart';
import 'core/utils/app_local_storage.dart';
import 'core/utils/my_bloc_observer.dart';
import 'core/utils/service_locator.dart';
import 'features/app/view/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await AppLocalStorage.init();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: ColorsManager.backgroundColor,
    ),
  );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => const SPApp(),
    ),
  );
  Bloc.observer = MyBlocObserver();
}