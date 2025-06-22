import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../home/data/dto/vote_dto.dart';
import '../../../home/data/model/post_model/post.dart';
import '../../../home/presentation/manager/discussion_bloc/discussion_bloc.dart';
import '../../../home/presentation/widgets/post_view.dart';
import '../screens/not_found_search_view.dart';

class SearchedPosts extends StatelessWidget {
  const SearchedPosts({super.key, this.discussions = const []});

  final List<Discussion> discussions;

  @override
  Widget build(BuildContext context) {
    if (discussions.isEmpty) return const NotFoundView();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => PostView(
        onSelect: (p0) {
          if(p0 == 'delete') {
            context.read<DiscussionBloc>().add(DeleteDiscussionEvent(discussions[index].id ?? ''),);
          }
        },
        discussion: discussions[index],
        navToDetails: true,
        onVoteTap: (p0) => context.read<DiscussionBloc>().add(VoteDiscussionEvent(voteDto: VoteDto(postId: discussions[index].id ?? '', voteType: p0))),
      ),
      itemCount: discussions.length,
    );
  }
}
