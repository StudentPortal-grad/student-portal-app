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
    on<DiscussionLoadMoreRequested>(_loadMoreDiscussions);
  }

  final GetPostsUc getPostsUc =
  GetPostsUc(getPostsRepo: getIt<PostRepository>());

  final List<Discussion> _posts = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  Future<void> _getDiscussions(
      DiscussionRequested event,
      Emitter<DiscussionState> emit,
      ) async {
    _currentPage = 1;
    _hasMore = true;
    _posts.clear();

    if (!event.noLoading) emit(DiscussionLoading());

    final response = await getPostsUc.call(page: _currentPage);
    response.fold(
          (error) => emit(DiscussionFailed(error.message ?? 'Unknown Error')),
          (posts) {
        _posts.addAll(posts);
        _hasMore = posts.isNotEmpty;
        emit(DiscussionLoaded(List.from(_posts), hasMore: _hasMore));
      },
    );
  }

  Future<void> _loadMoreDiscussions(
      DiscussionLoadMoreRequested event,
      Emitter<DiscussionState> emit,
      ) async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    _currentPage++;

    final response = await getPostsUc.call(page: _currentPage);
    response.fold(
          (error) {
        _currentPage--; // rollback on failure
        emit(DiscussionFailed(error.message ?? 'Pagination Failed'));
      },
          (posts) {
        if (posts.isEmpty) {
          _hasMore = false;
        } else {
          _posts.addAll(posts);
        }
        emit(DiscussionLoaded(List.from(_posts), hasMore: _hasMore));
      },
    );
    _isLoadingMore = false;
  }
}
