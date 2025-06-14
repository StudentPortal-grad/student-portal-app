import 'package:dartz/dartz.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../groups/data/models/user_sibling.dart';
import '../../../groups/domain/repo/group_repository.dart';

class SearchUsersSiblingsUc {
  final GroupRepository _groupRepository;

  SearchUsersSiblingsUc(this._groupRepository);

  Future<Either<Failure, List<UserSibling>>> call ({String? query}) => _groupRepository.getUsersSiblings(query: query);
}