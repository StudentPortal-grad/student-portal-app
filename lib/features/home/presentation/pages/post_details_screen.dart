import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/features/home/presentation/widgets/post_view.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../../data/dto/vote_dto.dart';
import '../../data/model/post_model/reply.dart';
import '../manager/discussion_details_bloc/discussion_details_bloc.dart';
import '../widgets/comment_bar.dart';
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
    final bloc = context.read<DiscussionDetailsBloc>();
    bloc.add(DiscussionDetailsEventRequest(bloc.discussion.id ?? ''));
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.backgroundColor,
      appBar: CustomAppBar(
        centerTitle: false,
        backgroundColor: ColorsManager.whiteColor,
        title: Text('Post', style: Styles.font20w600),
      ),
      body: BlocConsumer<DiscussionDetailsBloc, DiscussionDetailsState>(
        listener: (context, state) {
          if(state is AddCommentSuccessState){
            context.read<DiscussionDetailsBloc>().add(DiscussionDetailsEventRequest(context.read<DiscussionDetailsBloc>().discussion.id ?? ''));
          }
        },
        builder: (context, state) {
          final bloc = context.read<DiscussionDetailsBloc>();
          return CustomRefreshIndicator(
            onRefresh: () async => bloc.add(DiscussionDetailsEventRequest(bloc.discussion.id ?? '')),
            child: SingleChildScrollView(
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: PostView(
                onVoteTap: (p0) => bloc.add(VoteDiscussionEventRequest(voteDto: VoteDto(postId: bloc.discussion.id ?? '', voteType: p0)),),
                discussion: bloc.discussion,
                detailsChildren: [
                  5.heightBox,
                  CommentBar(),
                  10.heightBox,
                  ..._buildCommentsView(isLoading: state is DiscussionDetailsLoading,replies: bloc.discussion.replies ?? []),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  List<Widget> _buildCommentsView({bool isLoading = false,List<Reply> replies = const []}){
    if (isLoading) {
      return List.generate(3, (index) => PostCommentsView.buildShimmerComment());
    }
    return List.generate(replies.length, (index) => PostCommentsView(reply: replies[index]));
  }
}
