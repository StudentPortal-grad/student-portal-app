import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';
import '../../../core/utils/app_router.dart';
import '../../chats/presentation/manager/chats_bloc/chats_bloc.dart';
import '../../events/presentation/manager/events_bloc/events_bloc.dart';
import '../../home/presentation/manager/discussion_bloc/discussion_bloc.dart';
import '../../resource/presentation/manager/get_resource_bloc/get_resource_bloc.dart';
import '../manager/app_cubit/app_cubit.dart';
import '../manager/auth_cubit/auth_cubit.dart';

class SPApp extends StatelessWidget {
  const SPApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) => AppCubit()),
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<DiscussionBloc>(create: (_) => DiscussionBloc()..add(DiscussionRequested())),
        BlocProvider<EventsBloc>(create: (_) => EventsBloc()..add(EventsRequested())),
        BlocProvider<GetResourceBloc>(create: (_) => GetResourceBloc()..add(GetResourceEventRequested())),
        BlocProvider<ChatsBloc>(create: (context) => ChatsBloc()..add(StartListeningToConversations())),
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
