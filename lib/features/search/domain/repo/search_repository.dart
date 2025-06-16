import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';

import '../../data/model/global_search.dart';

abstract class SearchRepository {
  Future<Either<Failure, GlobalSearch>> globalSearch({required String? query});
}