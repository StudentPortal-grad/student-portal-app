import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_details_bloc/resource_details_bloc.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_react_bar_bloc/resource_react_bar_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utils/assets_app.dart';
import '../../../../../core/widgets/custom_image_view.dart';

class ResourceReactBar extends StatelessWidget {
  const ResourceReactBar({
    super.key,
    this.removeShare = false,
    this.comments,
    this.votes,
    this.currentVote = 0,
    this.onVoteTap,
  });

  final bool removeShare;
  final int? comments;
  final int? votes;
  final int currentVote;
  final Function(String)? onVoteTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceReactBarBloc, ResourceReactBarState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Row(
            children: [
              CustomImageView(
                margin: EdgeInsets.all(3.5.r),
                onTap: () {
                  context.read<ResourceReactBarBloc>().add(ResourceVoteChanged(1));
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
                  context.read<ResourceReactBarBloc>().add(ResourceVoteChanged(-1));
                  onVoteTap?.call('downvote');
                },
                imagePath: AssetsApp.arrowDownIcon,
                color: state.currentVote == -1 ? ColorsManager.orangeColor : null,
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
              Text((comments ?? 0).toString(), style: Styles.font14w500),
              Spacer(),
              GestureDetector(
                onTap: () {
                  final resource = context.read<ResourceDetailsBloc>().resource;
                  SharePlus.instance.share(
                    ShareParams(
                      text: ("Student Portal - Check out this ${resource.originalFileName} article:\n ${resource.fileUrl}"),
                    ),
                  );
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
