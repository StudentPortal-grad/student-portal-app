import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
        ),
      ),
    ),
  );
}
