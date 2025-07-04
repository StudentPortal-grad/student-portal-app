import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:student_portal/core/utils/secure_storage.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';
import 'package:student_portal/features/chats/data/repo_impl/messaging_impl.dart';
import 'package:student_portal/features/chats/domain/repo/messaging_repo.dart';
import 'package:student_portal/features/events/data/repositories/events_repository_impl.dart';
import 'package:student_portal/features/home/domain/repo/posts_repository.dart';
import 'package:student_portal/features/notification/data/repo/notification_repo_impl.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';
import 'package:student_portal/features/search/data/repo/search_repository_impl.dart';
import 'package:student_portal/features/search/domain/repo/search_repository.dart';

import '../../features/auth/data/repo_impl/auth_repo_impl.dart';
import '../../features/events/domain/repositories/events_repository.dart';
import '../../features/groups/data/repo_impl/group_repository_impl.dart';
import '../../features/groups/domain/repo/group_repository.dart';
import '../../features/home/data/repo_impl/posts_repository_impl.dart';
import '../../features/notification/domain/repo/notification_repo.dart';
import '../../features/profile/data/reoi_impl/profile_repository_impl.dart';
import '../../features/resource/data/repo_impl/resource_repository_impl.dart';
import '../../features/resource/domain/repo/resource_repository.dart';
import '../network/api_endpoints.dart';
import '../network/api_service.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<ApiService>(
    ApiService(
      Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      ),
    ),
  );
  // Register SecureStorage
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());
  // Register AuthRepository
  getIt.registerSingleton<AuthRepository>(AuthRepoImpl(apiService: getIt.get<ApiService>()));
  getIt.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(getIt.get<ApiService>()));
  // Register Events
  getIt.registerSingleton<EventsRepository>(EventsRepositoryImpl(apiService: getIt.get<ApiService>()));
  // Register Posts
  getIt.registerSingleton<PostRepository>(PostRepositoryImpl(apiService: getIt.get<ApiService>()));
  // Register Resources
  getIt.registerSingleton<ResourceRepository>(ResourceRepositoryImpl(getIt.get<ApiService>()));
  // Register Messages
  getIt.registerSingleton<MessagingRepo>(MessagingImpl(getIt.get<ApiService>()));
  // Register Group
  getIt.registerSingleton<GroupRepository>(GroupRepositoryImpl(getIt.get<ApiService>()));
  // Righter Search
  getIt.registerSingleton<SearchRepository>(SearchRepositoryImpl(getIt.get<ApiService>()));
  // Register Notifications
  getIt.registerSingleton<NotificationRepo>(NotificationRepoImpl(getIt.get<ApiService>()));
}
