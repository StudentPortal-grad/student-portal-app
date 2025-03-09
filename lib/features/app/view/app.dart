import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';
import '../../../core/utils/app_router.dart';
import '../manager/app_cubit/app_cubit.dart';
import '../manager/auth_cubit/auth_cubit.dart';

class SPApp extends StatelessWidget {
  const SPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => AuthCubit()), // Handles logout
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Student Portal',
          themeMode: ThemeMode.light,
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: ColorsManager.backgroundColor,
            primaryColor: ColorsManager.mainColor,
            primaryColorDark: ColorsManager.mainColorDark,
            primaryColorLight: ColorsManager.mainColorLight,
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
