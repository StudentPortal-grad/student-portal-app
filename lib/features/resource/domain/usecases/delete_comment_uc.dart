import 'package:dartz/dartz.dart';
import 'package:student_portal/features/resource/domain/repo/resource_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';

class DeleteResourceCommentUc {
  final ResourceRepository resourceRepository;

  DeleteResourceCommentUc(this.resourceRepository);

  Future<Either<Failure, String>> call({required String replyId,required String postId}) => resourceRepository.deleteReply(replyId: replyId,resourceId: postId);
}
