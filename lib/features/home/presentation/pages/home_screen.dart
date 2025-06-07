import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/view/error_screen.dart';
import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../core/widgets/loading_screen.dart';
import '../../data/model/post_model/post.dart';
import '../manager/discussion_bloc/discussion_bloc.dart';
import '../widgets/post_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscussionBloc, DiscussionState>(
      builder: (context, state) {
        if (state is DiscussionLoading) {
          return Center(
            child: LoadingScreen(
              highlightColor: ColorsManager.mainColor,
              baseColor: ColorsManager.mainColorLight,
            ),
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
          return HomeBodyView(discussions: state.discussions);
        }
        return SizedBox.shrink();
      },
    );
  }
}

class HomeBodyView extends StatelessWidget {
  const HomeBodyView({super.key, this.discussions = const []});

  final List<Discussion> discussions;

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async =>
          context.read<DiscussionBloc>().add(DiscussionRequested()),
      child: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
          separatorBuilder: (context, index) => 15.heightBox,
          itemBuilder: (context, index) => InkWell(
            // onTap: () => AppRouter.router.push(AppRouter.postDetails),
            child: PostView(discussion: discussions[index]),
          ),
          itemCount: 2,
        ),
      ),
    );
  }
}
