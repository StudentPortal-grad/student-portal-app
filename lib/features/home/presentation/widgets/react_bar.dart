import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../manager/react_bar_bloc/react_bar_bloc.dart';
import '../manager/react_bar_bloc/react_bar_event.dart';

class ReactBar extends StatelessWidget {
  const ReactBar({
    super.key,
    this.removeShare = false,
    this.comments,
    this.votes,
    this.onVoteTap,
    this.currentVote = 0,
  });

  final bool removeShare;
  final int? comments;
  final int? votes;
  final int currentVote;
  final Function(String)? onVoteTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReactBarBloc, ReactBarState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            children: [
              CustomImageView(
                margin: EdgeInsets.all(3.5.r),
                onTap: () {
                  context.read<ReactBarBloc>().add(VoteChanged(1));
                  onVoteTap?.call('upvote');
                },
                imagePath: AssetsApp.arrowUpIcon,
                color: state.currentVote == 1 ? ColorsManager.mainColorDark : null,
                width: 16.w,
                height: 16.h,
              ),
              4.widthBox,
              Text(state.upVotes.toString(), style: Styles.font14w500),
              4.widthBox,
              CustomImageView(
                margin: EdgeInsets.all(3.5.r),
                onTap: () {
                  context.read<ReactBarBloc>().add(VoteChanged(-1));
                  onVoteTap?.call('downvote');
                },
                imagePath: AssetsApp.arrowDownIcon,
                color:
                    state.currentVote == -1 ? ColorsManager.orangeColor : null,
                width: 16.w,
                height: 16.h,
              ),
              Spacer(),
              CustomImageView(
                imagePath: AssetsApp.commentIcon,
                color: Colors.grey[300],
                width: 16.w,
                height: 16.h,
              ),
              4.widthBox,
              Text(comments?.toString() ?? '0', style: Styles.font14w500),
              Spacer(),
              if (!removeShare)
                GestureDetector(
                  onTap: () {
                    try {
                      SharePlus.instance.share(
                        ShareParams(
                          title: 'Check out this article',
                          files: [],
                          // uri: Uri.tryParse('https://google.com'),
                        ),
                      );
                    } on Exception catch (e) {
                      log("share_error $e");
                    }
                  },
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: AssetsApp.shareIcon,
                        width: 16.w,
                        height: 16.h,
                      ),
                      4.widthBox,
                      Text('Share', style: Styles.font14w500),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
