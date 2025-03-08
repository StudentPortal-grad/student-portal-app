import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'package:student_portal/core/errors/data/model/error_model.dart';

import 'package:student_portal/features/chats/data/dto/message_dto.dart';

import 'package:student_portal/features/chats/data/model/message.dart';

import '../../../../core/errors/data/model/failures.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_service.dart';
import '../../domain/repo/messaging_repo.dart';

class MessagingImpl implements MessagingRepo {
  final ApiService apiService;

  MessagingImpl(this.apiService);

  @override
  Future<Either<Failure, List<Message>>> getConversations() async {
    try {
      final response =
          await apiService.get(endpoint: ApiEndpoints.conversations);
      log(response.toString());

      final messages = (response['data']?['conversations'] as List<dynamic>?)
              ?.map((json) => Message.fromJson(json))
              .toList() ?? [];

      return Right(messages);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, Message>> sendMessage(MessageDto messageDto) async {

    try {
      final response =
      await apiService.post(endpoint: ApiEndpoints.conversations, data: messageDto.toJson());
      log(response.toString());


      return Right(Message.fromJson(response));
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    }
  }
}
