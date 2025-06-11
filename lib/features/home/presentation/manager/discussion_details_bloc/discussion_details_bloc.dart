import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/home/data/dto/vote_dto.dart';
import 'package:student_portal/features/home/domain/usecases/vote_post_uc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../data/dto/reply_dto.dart';
import '../../../data/model/post_model/post.dart';
import '../../../domain/repo/posts_repository.dart';
import '../../../domain/usecases/comment_post_uc.dart';
import '../../../domain/usecases/get_post_details_us.dart';

part 'discussion_details_event.dart';

part 'discussion_details_state.dart';

class DiscussionDetailsBloc
    extends Bloc<DiscussionDetailsEvent, DiscussionDetailsState> {
  DiscussionDetailsBloc(this.discussion) : super(DiscussionDetailsInitial()) {
    on<DiscussionDetailsEventRequest>(_getDiscussion);
    on<CommentDiscussionEvent>(_commentDiscussion);
    on<VoteDiscussionEventRequest>(_voteDiscussion);
  }

  // usecases
  final GetPostDetailsUC getPostDetailsUC =
      GetPostDetailsUC(getIt<PostRepository>());
  final CommentPostUc commentPostUc = CommentPostUc(getIt<PostRepository>());
  final VotePostUc votePostUc = VotePostUc(getIt<PostRepository>());

  Discussion discussion;

  Future<void> _getDiscussion(DiscussionDetailsEventRequest event,
      Emitter<DiscussionDetailsState> emit) async {
    if(!event.noLoading) emit(DiscussionDetailsLoading());
    final result = await getPostDetailsUC.call(postId: event.postId);
    result.fold(
      (error) => emit(DiscussionDetailsError(error.message ?? 'Unknown Error')),
      (discussion) {
        this.discussion = discussion;
        emit(DiscussionDetailsLoaded(discussion));
      },
    );
  }

  Future<void> _commentDiscussion(CommentDiscussionEvent event,
      Emitter<DiscussionDetailsState> emit) async {
    emit(AddCommentLoadingState());
    final result = await commentPostUc.call(replyDto: event.replyDto);
    result.fold(
      (error) => emit(AddCommentErrorState(error.message ?? 'Unknown Error')),
      (message) => emit(AddCommentSuccessState(message)),
    );
  }

  Future<void> _voteDiscussion(VoteDiscussionEventRequest event,
      Emitter<DiscussionDetailsState> emit) async {
    final result = await votePostUc.call(voteDto: event.voteDto);
    result.fold(
      (error) => emit(VoteErrorState(error.message ?? 'Unknown Error')),
      (message) {
        final String? previousVote = _stringVote(discussion.currentVote);
        final String newVote = event.voteDto.voteType;

        int newUp = discussion.upVotesCount ?? 0;
        int newDown = discussion.downVotesCount ?? 0;

        if (previousVote == newVote) {
          // UnVoting
          if (newVote == 'upvote') newUp--;
          if (newVote == 'downvote') newDown--;

          discussion = discussion.copyWith(
            currentVote: null,
            upVotesCount: newUp,
            downVotesCount: newDown,
          );
        } else {
          // Switching or casting new vote
          if (previousVote == 'upvote') newUp--;
          if (previousVote == 'downvote') newDown--;

          if (newVote == 'upvote') newUp++;
          if (newVote == 'downvote') newDown++;

          discussion = discussion.copyWith(
            currentVote: _intVote(newVote),
            upVotesCount: newUp,
            downVotesCount: newDown,
          );
        }
        emit(VoteSuccessState());
      },
    );
  }

  String? _stringVote(int? vote) {
    if (vote == 1) return 'upvote';
    if (vote == -1) return 'downvote';
    return null;
  }

  int? _intVote(String vote) {
    if (vote == 'upvote') return 1;
    if (vote == 'downvote') return -1;
    return null;
  }
}
