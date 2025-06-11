import 'package:flutter_bloc/flutter_bloc.dart';

part 'resource_react_bar_event.dart';
part 'resource_react_bar_state.dart';

class ResourceReactBarBloc extends Bloc<ResourceReactBarEvent, ResourceReactBarState> {
  ResourceReactBarBloc() : super(const ResourceReactBarState(upVotes: 0, downVotes: 0, currentVote: 0)) {
    on<InitializeResourceVotes>(_onInitializeVotes);
    on<ResourceVoteChanged>(_onVoteChanged);
  }

  void _onInitializeVotes(InitializeResourceVotes event, Emitter<ResourceReactBarState> emit) {
    emit(ResourceReactBarState(
      upVotes: event.upVotes,
      downVotes: event.downVotes,
      currentVote: event.currentVote,
    ));
  }

  void _onVoteChanged(ResourceVoteChanged event, Emitter<ResourceReactBarState> emit) {
    int up = state.upVotes;
    int down = state.downVotes;
    int current = state.currentVote;

    if (current == event.vote) {
      // Un vote
      if (event.vote == 1) up--;
      if (event.vote == -1) down--;
      current = 0;
    } else {
      // Switch vote
      if (current == 1) up--;
      if (current == -1) down--;

      if (event.vote == 1) up++;
      if (event.vote == -1) down++;

      current = event.vote;
    }
    emit(ResourceReactBarState(upVotes: up, downVotes: down, currentVote: current));
  }
}
