import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:student_portal/features/home/data/dto/reply_dto.dart';
import 'package:student_portal/features/resource/domain/repo/resource_repository.dart';
import 'package:student_portal/features/resource/domain/usecases/comment_resource_uc.dart';
import 'package:student_portal/features/resource/domain/usecases/delete_comment_uc.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../home/data/dto/vote_dto.dart';
import '../../../data/model/resource.dart';
import '../../../domain/usecases/get_resource_details_uc.dart';
import '../../../domain/usecases/vote_resource_uc.dart';

part 'resource_details_event.dart';

part 'resource_details_state.dart';

class ResourceDetailsBloc
    extends Bloc<ResourceDetailsEvent, ResourceDetailsState> {
  ResourceDetailsBloc(this.resource) : super(ResourceDetailsInitial()) {
    on<GetResourceEvent>(_getResourceDetails);
    on<CommentResourceEvent>(_commentResource);
    on<VoteDiscussionEventRequest>(_voteResource);
    on<DeleteCommentResourceEvent>(_deleteComment);
  }

  // usecases
  final GetResourceDetailsUC getResourceUc = GetResourceDetailsUC(getIt<ResourceRepository>());
  final CommentResourceUc commentPostUc = CommentResourceUc(getIt<ResourceRepository>());
  final VoteResourceUc voteResourceUc = VoteResourceUc(getIt<ResourceRepository>());
  final DeleteResourceCommentUc deleteCommentUc = DeleteResourceCommentUc(getIt<ResourceRepository>());
  Resource resource;

  Future<void> _getResourceDetails(
      GetResourceEvent event, Emitter<ResourceDetailsState> emit) async {
    if (!event.noLoading) emit(ResourceDetailsLoadingState());
    final result = await getResourceUc.call(resourceId: event.resourceId);
    result.fold(
      (error) => emit(ResourceDetailsErrorState(error.message ?? 'Unknown Error')),
      (resource) {
        this.resource = resource;
        emit(ResourceDetailsLoadedState(resource));
      },
    );
  }

  Future<void> _commentResource(
      CommentResourceEvent event, Emitter<ResourceDetailsState> emit) async {
    emit(AddCommentLoadingState());
    final result = await commentPostUc.call(replyDto: event.replyDto);
    result.fold(
      (error) => emit(AddCommentErrorState(error.message ?? 'Unknown Error')),
      (message) => emit(AddCommentSuccessState(message)),
    );
  }

  Future<void> _deleteComment(DeleteCommentResourceEvent event,
      Emitter<ResourceDetailsState> emit) async {
    final result = await deleteCommentUc.call(
        replyId: event.replyId, postId: event.resourceId);
    result.fold((error) {
      emit(AddCommentErrorState(error.message ?? 'Unknown Error'));
    }, (message) {
      resource.comments?.removeWhere((reply) => reply.id == event.replyId);
      emit(ResourceDetailsLoadedState(resource, message: message));
    });
  }

  Future<void> _voteResource(VoteDiscussionEventRequest event,
      Emitter<ResourceDetailsState> emit) async  {
    final result = await voteResourceUc.call(voteDto: event.voteDto);
    result.fold(
          (error) => emit(VoteErrorState(error.message ?? 'Unknown Error')),
          (message) {
        final String? previousVote = _stringVote(resource.currentVote);
        final String newVote = event.voteDto.voteType;

        int newUp = resource.upVotesCount ?? 0;
        int newDown = resource.downVotesCount ?? 0;

        if (previousVote == newVote) {
          // UnVoting
          if (newVote == 'upvote' && newUp > 0) newUp--;
          if (newVote == 'downvote' && newDown > 0) newDown--;

          resource = resource.copyWith(
            currentVote: resource.currentVote,
            upVotesCount: newUp,
            downVotesCount: newDown,
          );
        } else {
          // Switching or casting new vote
          if (previousVote == 'upvote' && newUp > 0) newUp--;
          if (previousVote == 'downvote' && newDown > 0) newDown--;

          if (newVote == 'upvote') newUp++;
          if (newVote == 'downvote') newDown++;

          resource = resource.copyWith(
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
