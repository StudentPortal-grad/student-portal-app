import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:student_portal/core/network/api_service.dart';
import 'package:student_portal/features/search/data/model/global_search.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repo/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiService apiService;

  SearchRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, GlobalSearch>> globalSearch(
      {required String? query}) async {
    try {
      log('Searching for ::: $query');
      final response = await apiService.get(endpoint: ApiEndpoints.globalSearch, query: {
        'q': query ?? '',
      });
      log('Searched :: $response');
      return Right(GlobalSearch.fromJson(response['data'] as Map<String, dynamic>));
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
