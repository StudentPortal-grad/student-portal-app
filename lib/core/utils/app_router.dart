import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/features/chats/presentation/manager/conversation_bloc/conversation_bloc.dart';
import 'package:student_portal/features/chats/presentation/pages/dm_screen.dart';
import 'package:student_portal/features/chats/presentation/pages/search_peer_screen.dart';
import 'package:student_portal/features/community/presentation/screens/community_screen.dart';
import 'package:student_portal/features/community/presentation/screens/create_community_screen.dart';
import 'package:student_portal/features/home/presentation/manager/create_post_bloc/create_post_bloc.dart';
import 'package:student_portal/features/home/presentation/manager/discussion_details_bloc/discussion_details_bloc.dart';
import 'package:student_portal/features/home/presentation/pages/add_post_screen.dart';
import 'package:student_portal/features/home/presentation/pages/post_details_screen.dart';
import 'package:student_portal/features/profile/presentation/screens/following_screen.dart';
import 'package:student_portal/features/profile/presentation/screens/profile_screen.dart';
import 'package:student_portal/features/groups/presentation/screens/create_group_screen.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_details_bloc/resource_details_bloc.dart';
import 'package:student_portal/features/resource/presentation/pages/add_resource_screen.dart';
import 'package:student_portal/features/search/presentation/screens/search_screen.dart';
import 'package:student_portal/features/settings/presentation/screens/account_settings_screen.dart';
import '../../features/auth/data/model/user_model/user.dart';
import '../../features/auth/presentation/manager/login_bloc/login_bloc.dart';
import '../../features/auth/presentation/manager/signup_bloc/signup_bloc.dart';
import '../../features/auth/presentation/manager/signup_bloc/signup_event.dart';
import '../../features/auth/presentation/screens/forget_password.dart';
import '../../features/auth/presentation/screens/login_view.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/auth/presentation/screens/set_new_password.dart';
import '../../features/auth/presentation/screens/signup_view.dart';
import '../../features/events/presentation/pages/event_details.dart';
import '../../features/home/data/model/post_model/post.dart';
import '../../features/home_layout/ui/home_layout_screen.dart';
import '../../features/notification/presentation/screens/notifications_screen.dart';
import '../../features/onboarding/view/onboarding_view/onboarding_view.dart';
import '../../features/onboarding/view/splash_view/splash_view.dart';
import '../../features/profile/presentation/screens/followers_screen.dart';
import '../../features/resource/data/model/resource.dart';
import '../../features/resource/presentation/manager/upload_resource_bloc/upload_resource_bloc.dart';
import '../../features/resource/presentation/pages/resource_details_screen.dart';
import '../helpers/custom_animated_transition_page.dart';

abstract class AppRouter {
  static BuildContext? get context =>
      router.routerDelegate.navigatorKey.currentContext;

  // auth
  static const String splashView = '/';
  static const String onBoardingView = '/boarding';
  static const String loginView = '/login';
  static const String signupView = '/sing_up';
  static const String otpForgetPass = '/otp_forget_pass';
  static const String setNewPassword = '/set_password';
  static const String forgetPasswordView = '/forget_password';

  // home
  static const String homeView = '/home';
  static const String addPost = '/add_post';
  static const String addResource = '/add_resource';
  static const String createCommunity = '/create_community';
  static const String postDetails = '/post_details';
  static const String resourceDetails = '/resource_details';

  //event
  static const String eventDetails = '/event_details';

  //chat
  static const String dmScreen = '/dm';
  static const String createGroup = '/create_group';
  static const String searchPeer = '/search_peer';

  // search
  static const String searchScreen = '/search';

  // notification
  static const String notification = '/notification';

  // profile
  static const String profile = '/profile';
  static const String followings = '/followings';
  static const String followers = '/followers';

  // community
  static const String community = '/community';

  // settings
  static const String accountSettings = '/settings';

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
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            useSlideTransition: true,
            context: context,
            state: state,
            child: withBlocProvider(
              create: (context) {
                final bloc = SignupBloc();
                if (args != null && args['emailNotVerified'] == true) {
                  bloc.emailController.text = args['email'];
                  bloc.add(ResendCodeRequested(email: args['email'] ?? UserRepository.user?.email ?? ""));
                  return bloc;
                }
                return bloc;
              },
              child: const SignupView(),
            ),
          );
        },
      ),
      GoRoute(
        path: loginView,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: withBlocProvider(
            create: (context) => LoginBloc(),
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
        path: otpForgetPass,
        pageBuilder: (context, state) {
          if (state.extra is Map<String, dynamic>) {
            final args = state.extra as Map<String, dynamic>?;
            return buildPage(
              context: context,
              state: state,
              useSlideTransition: true,
              child: OtpView(email: args?['email'] ?? ''),
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
          child: BlocProvider(
            create: (context) => CreatePostBloc(),
            child: AddPostScreen(),
          ),
        ),
      ),
      GoRoute(
        path: addResource,
        pageBuilder: (context, state) => buildPage(
          context: context,
          state: state,
          child: BlocProvider(
            create: (context) => UploadResourceBloc(),
            child: AddResourcesScreen(),
          ),
        ),
      ),
      GoRoute(
        path: eventDetails,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            context: context,
            state: state,
            child: EventDetailsScreen(eventId: args?['eventId'] ?? ''),
          );
        },
      ),
      GoRoute(
        path: postDetails,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            context: context,
            state: state,
            child: BlocProvider(
              create: (context) => DiscussionDetailsBloc(args?['post'] as Discussion)..add(DiscussionDetailsEventRequest(postId: args?['post'].id ?? '')),
              child: PostDetailsScreen(),
            ),
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
            child: BlocProvider(
              create: (context) => ResourceDetailsBloc(args?['resource'] as Resource)..add(GetResourceEvent(resourceId: args?['resource'].id ?? '')),
              child: ResourceDetailsScreen(),
            ),
          );
        },
      ),
      GoRoute(
        path: createGroup,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: true,
          context: context,
          state: state,
          child: const CreateGroupScreen(),
        ),
      ),
      GoRoute(
        path: searchPeer,
        pageBuilder: (context, state) => buildPage(
          useSlideTransition: false,
          context: context,
          state: state,
          child: const SearchPeerScreen(),
        ),
      ),
      GoRoute(
        path: dmScreen,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          final conversationId = args?['conversationId'] as String;
          return buildPage(
            context: context,
            state: state,
            child: BlocProvider(
              create: (context) => ConversationBloc()..add(GetConversationEvent(conversationId: conversationId)),
              child: DmScreen(user: args?['user'] as User?),
            ),
          );
        },
      ),
      GoRoute(
        path: searchScreen,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: SearchScreen(),
          );
        },
      ),
      GoRoute(
        path: notification,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: NotificationsScreen(),
          );
        },
      ),
      GoRoute(
        path: profile,
        pageBuilder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return buildPage(
            context: context,
            state: state,
            child: ProfileScreen(userId: args?['userId'] as String?),
          );
        },
      ),
      GoRoute(
        path: followers,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: FollowersScreen(),
          );
        },
      ),
      GoRoute(
        path: followings,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: FollowingScreen(),
          );
        },
      ),
      GoRoute(
        path: createCommunity,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: CreateCommunityScreen(),
          );
        },
      ),
      GoRoute(
        path: accountSettings,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: AccountSettingsScreen(),
          );
        },
      ),
      GoRoute(
        path: community,
        pageBuilder: (context, state) {
          return buildPage(
            context: context,
            state: state,
            child: CommunityScreen(),
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
