import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/app_router.dart';
import '../mange/app_cubit.dart';

class SPApp extends StatelessWidget {
  const SPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Student Portal',
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
