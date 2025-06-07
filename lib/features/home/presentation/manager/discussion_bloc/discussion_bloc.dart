import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/core/utils/service_locator.dart';

import '../../../data/model/post_model/post.dart';
import '../../../domain/repo/posts_repository.dart';
import '../../../domain/usecases/get_posts_uc.dart';

part 'discussion_event.dart';

part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  DiscussionBloc() : super(DiscussionInitial()) {
    on<DiscussionRequested>(_getDiscussions);
  }

  final GetPostsUc getPostsUc =
      GetPostsUc(getPostsRepo: getIt<PostRepository>());

  Future<void> _getDiscussions(
      DiscussionRequested event, Emitter<DiscussionState> emit) async {
    if (!event.noLoading) emit(DiscussionLoading());
    final response = await getPostsUc.call();
    response.fold(
      (error) => emit(DiscussionFailed(error.message ?? 'Unknown Error')),
      (response) => emit(DiscussionLoaded(response)),
    );
  }
}
