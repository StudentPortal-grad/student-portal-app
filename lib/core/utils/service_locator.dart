import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:student_portal/core/utils/secure_storage.dart';
import 'package:student_portal/features/auth/domain/repo/auth_repo.dart';
import 'package:student_portal/features/profile/domain/repo/profile_repository.dart';

import '../../features/auth/data/repo_impl/auth_repo_impl.dart';
import '../../features/profile/data/reoi_impl/profile_repository_impl.dart';
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
}
