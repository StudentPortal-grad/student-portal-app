import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_portal/core/helpers/custom_toast.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/view/error_screen.dart';
import '../../../../core/widgets/loading_screen.dart';
import '../manager/discussion_bloc/discussion_bloc.dart';
import '../widgets/home_body_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscussionBloc, DiscussionState>(
      listener: (context, state) {
        if (state is DiscussionFailed) {
          CustomToast(context).showErrorToast(message: state.message);
        }
        if (state is DiscussionLoaded) {
          if (state.message?.isNotEmpty ?? false) {
            CustomToast(context).showSuccessToast(message: state.message);
          }
        }
      },
      builder: (context, state) {
        if (state is DiscussionLoading) {
          return Center(
            child: LoadingScreen(useMainColors: true),
          );
        }
        if (state is DiscussionFailed) {
          return ErrorScreen(
            failure: Failure(message: state.message),
            onRetry: () async => BlocProvider.of<DiscussionBloc>(context)
                .add(DiscussionRequested()),
          );
        }
        if (state is DiscussionLoaded) {
          return HomeBodyView(discussions: state.posts);
        }
        return SizedBox.shrink();
      },
    );
  }
}
