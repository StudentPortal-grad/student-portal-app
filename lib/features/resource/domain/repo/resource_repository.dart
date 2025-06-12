import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../../home/data/dto/reply_dto.dart';
import '../../../home/data/dto/vote_dto.dart';
import '../../data/dto/upload_resource.dart';
import '../../data/model/resource.dart';

abstract class ResourceRepository {
  Future<Either<Failure, String>> uploadResource({
    required ResourceDto resourceDto,
    void Function(int percent)? onProgress,
  });

  Future<Either<Failure, List<Resource>>> getResources({int page = 1});

  Future<Either<Failure, Resource>> getResourceId({required String resourceId});

  Future<Either<Failure, String>> deleteResource({required String resourceId});

  Future<Either<Failure, String>> vote({required VoteDto voteDto});

  Future<Either<Failure, String>> reply({required ReplyDto replyDto});

  Future<Either<Failure, String>> deleteReply({required String replyId,required String resourceId});
}
