import 'package:dartz/dartz.dart';
import 'package:student_portal/features/resource/domain/repo/resource_repository.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../home/data/dto/reply_dto.dart';

class CommentResourceUc {
  final ResourceRepository resourceRepository;

  CommentResourceUc(this.resourceRepository);

  Future<Either<Failure, String>> call({required ReplyDto replyDto}) => resourceRepository.reply(replyDto: replyDto);
}
