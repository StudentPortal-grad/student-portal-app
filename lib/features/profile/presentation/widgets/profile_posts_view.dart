import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/features/home/domain/entities/post_entity.dart';

import '../../../home/data/dto/vote_dto.dart';
import '../../../home/presentation/manager/discussion_bloc/discussion_bloc.dart';
import '../../../home/presentation/widgets/post_view.dart';

class ProfilePostsView extends StatelessWidget {
  const ProfilePostsView({super.key, this.posts = const []});

  final List<PostEntity> posts;

  @override
  Widget build(BuildContext context) {
    if(posts.isEmpty) {
      return Padding(padding: EdgeInsets.symmetric(vertical: 0.25.sh),child: "There's no Posts".make());
    }
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => PostView(
        onSelect: (p0) {
          if(p0 == 'delete') {
            context.read<DiscussionBloc>().add(DeleteDiscussionEvent(posts[index].id ?? ''),);
          }
        },
        onVoteTap: (p0) => context.read<DiscussionBloc>().add(VoteDiscussionEvent(voteDto: VoteDto(postId: posts[index].id ?? '', voteType: p0))),
        discussion: posts[index],
        navToDetails: true,
      ),
      itemCount: posts.length,
    );
  }
}
