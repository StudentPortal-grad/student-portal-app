import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/features/home/presentation/manager/react_bar_bloc/react_bar_event.dart';
part 'react_bar_state.dart';

class ReactBarBloc extends Bloc<ReactBarEvent, ReactBarState> {
  ReactBarBloc() : super(const ReactBarState(upVotes: 0, downVotes: 0, currentVote: 0)) {
    on<InitializeVotes>(_onInitializeVotes);
    on<VoteChanged>(_onVoteChanged);
  }

  void _onInitializeVotes(InitializeVotes event, Emitter<ReactBarState> emit) {
    emit(ReactBarState(
      upVotes: event.upVotes,
      downVotes: event.downVotes,
      currentVote: event.currentVote,
    ));
  }

  void _onVoteChanged(VoteChanged event, Emitter<ReactBarState> emit) {
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
    emit(ReactBarState(upVotes: up, downVotes: down, currentVote: current));
  }
}
