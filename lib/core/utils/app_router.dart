import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_portal/core/utils/service_locator.dart';
import 'package:student_portal/features/auth/domain/usecases/login_uc.dart';
import 'package:student_portal/features/auth/presentation/mange/signup_bloc/signup_bloc.dart';
import 'package:student_portal/features/post/presentation/pages/add_post_screen.dart';
import 'package:student_portal/features/post/presentation/pages/post_details_screen.dart';
import 'package:student_portal/features/resource/presentation/pages/resource_details_screen.dart';
import '../../features/auth/data/repo_impl/login_repo_impl.dart';
import '../../features/auth/presentation/mange/login_bloc/login_bloc.dart';
import '../../features/auth/presentation/view/forget_password/forget_password.dart';
import '../../features/auth/presentation/view/login_view/login_view.dart';
import '../../features/auth/presentation/view/otp_view/otp_screen.dart';
import '../../features/auth/presentation/view/set_new_password/set_new_password.dart';
import '../../features/auth/presentation/view/signup_view/signup_view.dart';
import '../../features/home_layout/ui/home_layout_screen.dart';
import '../../features/onboarding/view/onboarding_view/onboarding_view.dart';
import '../../features/onboarding/view/splash_view/splash_view.dart';
import '../../features/resource/presentation/pages/add_resource_screen.dart';
import '../helpers/custom_animated_transition_page.dart';
import '../network/api_service.dart';

abstract class AppRouter {
  static BuildContext? get context =>
      router.routerDelegate.navigatorKey.currentContext;

  // auth
  static const String splashView = '/s';
  static const String onBoardingView = '/boarding';
  static const String signupView = '/sing_up';
  static const String otpView = '/otp';
  static const String loginView = '/login';
  static const String setNewPassword = '/set_password';
  static const String forgetPasswordView = '/forget_password';

  // home
  static const String homeView = '/';
  static const String addPost = '/add_post';
  static const String addResource = '/add_resource';
  static const String postDetails = '/post_details';
  static const String resourceDetails = '/resource_details';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: splashView,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: onBoardingView,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: const OnboardingView(),
        ),
      ),
      GoRoute(
        path: signupView,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: withBlocProvider(
            create: (context) => SignupBloc(),
            child: const SignupView(),
          ),
        ),
      ),
      GoRoute(
        path: loginView,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: withBlocProvider(
            create: (context) => LoginBloc(
              loginUc:
                  LoginUc(loginRepo: LoginRepoImpl(getIt.get<ApiService>())),
            ),
            child: const LoginView(),
          ),
        ),
      ),
      GoRoute(
        path: forgetPasswordView,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: const ForgetPassword(),
        ),
      ),
      GoRoute(
        path: otpView,
        pageBuilder: (context, state) {
          if (state.extra is Map<String, dynamic>) {
            final args = state.extra as Map<String, dynamic>?;
            return buildPage(
              context: context,
              state: state,
              useSlideTransition: true,
              child: OtpView(
                email: args?['email'] ?? '',
                isForgetPassword: args?['isForgetPassword'] as bool?,
              ),
            );
          } else {
            return buildPage(
              context: context,
              state: state,
              child: const Scaffold(
                body: Center(child: Text('Invalid OTP data')),
              ),
            );
          }
        },
      ),
      GoRoute(
        path: setNewPassword,
        pageBuilder: (context, state) => buildPage(
          context: context,
          state: state,
          child: const SetNewPassword(),
          useSlideTransition: true,
        ),
      ),
      GoRoute(
        path: homeView,
        pageBuilder: (context, state) => buildPage(
          context: context,
          state: state,
          child: const HomeLayoutScreen(),
          useSlideTransition: true,
        ),
      ),
      GoRoute(
        path: addPost,
        pageBuilder: (context, state) => buildPage(
          context: context,
          state: state,
          child: AddPostScreen(),
        ),
      ),
      GoRoute(
        path: addResource,
        pageBuilder: (context, state) => buildPage(
          context: context,
          state: state,
          child: AddResourcesScreen(),
        ),
      ),
      GoRoute(
        path: postDetails,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            context: context,
            state: state,
            child: PostDetailsScreen(),
          );
        },
      ),
      GoRoute(
        path: resourceDetails,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            context: context,
            state: state,
            child: ResourceDetailsScreen(),
          );
        },
      ),
    ],
  );

  static void clearAndNavigate(String path) {
    router.go(path);
  }

  static CustomTransitionPage buildPage<T>({
    required BuildContext context,
    required GoRouterState state,
    required Widget child,
    bool useSlideTransition = false,
  }) {
    return useSlideTransition
        ? buildPageWithSlideTransition(
            context: context, state: state, child: child)
        : buildPageWithFadeTransition(
            context: context, state: state, child: child);
  }

  static Widget withBlocProvider<T extends StateStreamableSource<Object?>>({
    required T Function(BuildContext) create,
    required Widget child,
  }) {
    return BlocProvider(
      create: create,
      child: child,
    );
  }
}
