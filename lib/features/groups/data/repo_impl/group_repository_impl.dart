import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/network/api_service.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../domain/repo/group_repository.dart';
import '../dto/create_group_dto.dart';
import '../models/user_sibling.dart';

class GroupRepositoryImpl implements GroupRepository {
  final ApiService apiService;

  GroupRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, List<UserSibling>>> getUsersSiblings() async {
    try {
      final response = await apiService.get(
        endpoint: ApiEndpoints.usersSiblings,
        query: {},
      );
      log('Sibling Users:: $response');
      return Right(response['data']?.map<UserSibling>((e) => UserSibling.fromJson(e)).toList() ?? []);
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }
  @override
  Future<Either<Failure, String>> createGroup(CreateGroupDto createGroupDto) async {
    try {
      final response = await apiService.post(
        endpoint: ApiEndpoints.createGroup,
        formData: await createGroupDto.toFormData(),
      );
      log('Group Created:: $response');
      return const Right('Group Created Successfully');
    } on DioException catch (e) {
      log('Dio Failure ${e.toString()}');
      return Left(ServerFailure.fromDioError(e)); // Handle Dio errors here
    }
  }
}
