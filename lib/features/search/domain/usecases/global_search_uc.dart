import 'package:dartz/dartz.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/features/search/data/model/global_search.dart';
import 'package:student_portal/features/search/domain/repo/search_repository.dart';

class GlobalSearchUc {
  final SearchRepository searchRepository;

  GlobalSearchUc(this.searchRepository);

  Future<Either<Failure, GlobalSearch>> call({required String? query}) async => await searchRepository.globalSearch(query: query);
}
