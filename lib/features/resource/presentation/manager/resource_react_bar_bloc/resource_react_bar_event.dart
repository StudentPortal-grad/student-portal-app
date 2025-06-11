part of 'resource_react_bar_bloc.dart';

abstract class ResourceReactBarEvent {}

class InitializeResourceVotes extends ResourceReactBarEvent {
  final int upVotes;
  final int downVotes;
  final int currentVote;

  InitializeResourceVotes({
    required this.upVotes,
    required this.downVotes,
    required this.currentVote,
  });
}

class ResourceVoteChanged extends ResourceReactBarEvent {
  final int vote;

  ResourceVoteChanged(this.vote);
}
