abstract class ReactBarEvent {}

class InitializeVotes extends ReactBarEvent {
  final int upVotes;
  final int downVotes;
  final int currentVote;

  InitializeVotes({
    required this.upVotes,
    required this.downVotes,
    required this.currentVote,
  });
}

class VoteChanged extends ReactBarEvent {
  final int vote; // 1 for upvote, -1 for downvote

  VoteChanged(this.vote);
}
