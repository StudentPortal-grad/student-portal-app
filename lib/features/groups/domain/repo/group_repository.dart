import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/groups/data/dto/create_group_dto.dart';
import '../../data/models/user_sibling.dart';

abstract class GroupRepository {
  Future<Either<Failure, List<UserSibling>>> getUsersSiblings();
  Future<Either<Failure, String>> createGroup(CreateGroupDto createGroupDto);
  }
