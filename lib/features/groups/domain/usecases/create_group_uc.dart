import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/dto/create_group_dto.dart';
import '../repo/group_repository.dart';

class CreateGroupUc {
  final GroupRepository _groupRepository;

  CreateGroupUc(this._groupRepository);

  Future<Either<Failure, String>> createGroup(CreateGroupDto createGroupDto) => _groupRepository.createGroup(createGroupDto);
}