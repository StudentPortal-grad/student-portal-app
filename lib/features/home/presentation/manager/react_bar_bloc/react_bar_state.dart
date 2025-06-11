part of 'react_bar_bloc.dart';

class ReactBarState {
  final int upVotes;
  final int downVotes;
  final int currentVote;

  const ReactBarState({
    required this.upVotes,
    required this.downVotes,
    required this.currentVote,
  });

  ReactBarState copyWith({
    int? upVotes,
    int? downVotes,
    int? currentVote,
  }) {
    return ReactBarState(
      upVotes: upVotes ?? this.upVotes,
      downVotes: downVotes ?? this.downVotes,
      currentVote: currentVote ?? this.currentVote,
    );
  }
}
