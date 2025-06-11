import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_details_bloc/resource_details_bloc.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/utils/assets_app.dart';
import '../../../../../core/widgets/custom_image_view.dart';

class ResourceReactBar extends StatefulWidget {
  const ResourceReactBar(
      {super.key,
      this.removeShare = false,
      this.comments,
      this.votes,
      required this.currentVote,
      this.onVoteTap});

  final bool removeShare;
  final int? comments;
  final int? votes;
  final int currentVote;
  final Function(String)? onVoteTap;

  @override
  State<ResourceReactBar> createState() => _ResourceReactBarState();
}

class _ResourceReactBarState extends State<ResourceReactBar> {
  int upVotes = 0;
  int downVotes = 0;
  int myReact = 0;

  @override
  void initState() {
    super.initState();
    upVotes = widget.votes ?? 0;
    downVotes = 0;
    myReact = widget.currentVote;
  }

  @override
  void didUpdateWidget(covariant ResourceReactBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    upVotes = widget.votes ?? 0;
    downVotes = 0;
    myReact = widget.currentVote;
  }

  void _onItemTapped(int vote) {
    setState(() {
      if (myReact == vote) {
        // Undo current reaction
        if (vote == 1) upVotes--;
        if (vote == -1) downVotes--;
        myReact = 0;
      } else {
        // Switch reactions
        if (myReact == 1) upVotes--;
        if (myReact == -1) downVotes--;

        if (vote == 1) upVotes++;
        if (vote == -1) downVotes++;

        myReact = vote;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          CustomImageView(
            margin: EdgeInsets.all(3.5.r),
            onTap: () {
              _onItemTapped((myReact == 1) ? 0 : 1);
              widget.onVoteTap?.call('upvote');
            },
            imagePath: AssetsApp.arrowUpIcon,
            color: myReact == 1 ? ColorsManager.mainColorDark : null,
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text(upVotes.toString(), style: Styles.font14w500),
          4.widthBox,
          CustomImageView(
            margin: EdgeInsets.all(3.5.r),
            onTap: () {
              _onItemTapped((myReact == -1) ? 0 : -1);
              widget.onVoteTap?.call('downvote');
            },
            imagePath: AssetsApp.arrowDownIcon,
            color: myReact == -1 ? ColorsManager.orangeColor : null,
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
          Text((widget.comments ?? 0).toString(), style: Styles.font14w500),
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
  }
}
