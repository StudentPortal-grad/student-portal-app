import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/app_router.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/features/home/presentation/widgets/post_view.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/helpers/custom_toast.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/dto/vote_dto.dart';
import '../../data/model/post_model/post.dart';
import '../manager/discussion_details_bloc/discussion_details_bloc.dart';
import '../widgets/comment_bar.dart';
import '../widgets/discussion_shimmer.dart';
import '../widgets/post_comments_view.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({super.key});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final Discussion discussion =
              context.read<DiscussionDetailsBloc>().discussion;
          AppRouter.router.pop(discussion);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorsManager.backgroundColor,
        appBar: CustomAppBar(
          centerTitle: false,
          leadingOnTap: () {
            final Discussion discussion =
                context.read<DiscussionDetailsBloc>().discussion;
            AppRouter.router.pop(discussion);
          },
          backgroundColor: ColorsManager.whiteColor,
          title: Text('Post', style: Styles.font20w600),
        ),
        body: BlocConsumer<DiscussionDetailsBloc, DiscussionDetailsState>(
          listener: (context, state) {
            if (state is AddCommentSuccessState) {
              context.read<DiscussionDetailsBloc>().add(DiscussionDetailsEventRequest(postId: context.read<DiscussionDetailsBloc>().discussion.id ?? '', noLoading: true));
            }
            if (state is DiscussionDetailsLoaded) {
              if (state.message?.isNotEmpty ?? false) {
                CustomToast(context).showSuccessToast(message: state.message, durationInMillis: 3000);
              }
            }
          },
          builder: (context, state) {
            final bloc = context.read<DiscussionDetailsBloc>();
            if (state is DiscussionDetailsLoading) {
              return DiscussionShimmer();
            }
            if (state is DiscussionDetailsError) {
              return ErrorScreen(
                  onRetry: () => bloc.add(DiscussionDetailsEventRequest(
                      postId: bloc.discussion.id ?? '')),
                  failure: Failure(message: state.message));
            }

            return CustomRefreshIndicator(
              onRefresh: () async => bloc.add(DiscussionDetailsEventRequest(
                  postId: bloc.discussion.id ?? '', noLoading: true)),
              child: SingleChildScrollView(
                controller: scrollController,
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: PostView(
                  onVoteTap: (p0) => bloc.add(
                    VoteDiscussionEventRequest(
                        voteDto: VoteDto(
                            postId: bloc.discussion.id ?? '', voteType: p0)),
                  ),
                  discussion: bloc.discussion,
                  detailsChildren: [
                    5.heightBox,
                    CommentPostBar(),
                    10.heightBox,
                    ...List.generate(
                      bloc.discussion.replies?.length ?? 0,
                      (index) => PostCommentsView(
                        onSelect: (p0) {
                          final reply = bloc.discussion.replies?[index];
                          if(p0 == 'delete') {
                            bloc.add(DeleteCommentDiscussionEvent(replyId: reply?.id ?? '' , postId: bloc.discussion.id ?? ''));
                          }
                        },
                        reply: bloc.discussion.replies?[index],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
