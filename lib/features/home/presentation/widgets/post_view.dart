import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/app_text.dart';
import 'package:student_portal/features/home/data/model/post_model/post.dart';
import 'package:student_portal/features/home/presentation/widgets/post_list_images_view.dart';
import 'package:student_portal/features/home/presentation/widgets/react_bar.dart';
import 'package:student_portal/features/home/presentation/widgets/user_post_view.dart';

import '../../../../core/helpers/time_formatting_helper.dart';
import '../../../../core/utils/app_router.dart';
import '../manager/discussion_bloc/discussion_bloc.dart';
import '../manager/react_bar_bloc/react_bar_bloc.dart';
import '../manager/react_bar_bloc/react_bar_event.dart';

class PostView extends StatefulWidget {
  const PostView(
      {super.key,
      this.detailsChildren,
      this.discussion,
      this.onVoteTap,
      this.navToDetails = false});

  final Discussion? discussion;
  final List<Widget>? detailsChildren;
  final Function(String)? onVoteTap;
  final bool navToDetails;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late final ReactBarBloc _reactBarBloc;

  @override
  void initState() {
    super.initState();
    _reactBarBloc = ReactBarBloc()
      ..add(
        InitializeVotes(
          upVotes: widget.discussion?.upVotesCount ?? 0,
          downVotes: widget.discussion?.downVotesCount ?? 0,
          currentVote: widget.discussion?.currentVote ?? 0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reactBarBloc,
      child: GestureDetector(
        onTap: ()async {
          if (widget.navToDetails) {
            final updatedPost = await AppRouter.router.push<Discussion>(
              AppRouter.postDetails,
              extra: {'post': widget.discussion},
            );
            if (updatedPost != null) {
              log('updatedPost: ${updatedPost.toJson()}');
              final bloc = context.mounted
                  ? context.read<DiscussionBloc>()
                  : AppRouter.context?.read<DiscussionBloc>();
              if (bloc != null) {
                bloc.add(UpdateDiscussionInListEvent(updatedPost));
              }
              _reactBarBloc.add(
                InitializeVotes(
                  upVotes: updatedPost.upVotesCount ?? 0,
                  downVotes: updatedPost.downVotesCount ?? 0,
                  currentVote: updatedPost.currentVote ?? 0,
                ),
              );
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 7,
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          padding: EdgeInsets.all(18.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserPostView(
                uploader: widget.discussion?.uploader,
                createFromAgo: TimeHelper.instance.timeAgo(widget.discussion?.createdAt),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  21.heightBox,
                  Text(widget.discussion?.title ?? '', style: Styles.font14w700),
                  10.heightBox,
                  AppText(
                    onHashTagTap: (p0) {
                      debugPrint('HASH TAG');
                      debugPrint(p0);
                    },
                    onMentionTap: (p0) {
                      debugPrint('on Mention');
                      debugPrint(p0);
                    },
                    text: widget.discussion?.content ?? '',
                    style: Styles.font12w400
                        .copyWith(color: ColorsManager.grayColor, height: 1.9),
                  ),
                  15.heightBox,
                ],
              ),
              PostListImagesView(attachments: widget.discussion?.attachments ?? []),
              15.heightBox,
              // react bar
              ReactBar(
                comments: widget.discussion?.replies?.length ?? 0,
                onVoteTap: (p0) {
                  log('onVoteTap $p0');
                  widget.onVoteTap?.call(p0);
                },
              ),
              if (widget.detailsChildren != null) ...[
                17.heightBox,
                ...widget.detailsChildren!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
// tags layout

// Wrap(
//   spacing: 7.w,
//   runSpacing: 7.h,
//   children: List.generate(
//     discussion.tags.length,
//         (index) =>
//         CategoryTagView(
//           index: index,
//           title:  discussion.tags[index],
//         ),
//   ),
// ),
// 20.heightBox,
