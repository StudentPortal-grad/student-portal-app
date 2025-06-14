import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../data/models/user_sibling.dart';
import '../repo/group_repository.dart';

class GetUsersSiblingsUc {
  final GroupRepository _groupRepository;

  GetUsersSiblingsUc(this._groupRepository);

  Future<Either<Failure, List<UserSibling>>> getUsersSiblings() => _groupRepository.getUsersSiblings();
}