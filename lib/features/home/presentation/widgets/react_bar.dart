import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';

class ReactBar extends StatefulWidget {
  const ReactBar({
    super.key,
    this.removeShare = false,
    this.comments,
    this.votes,
    this.onVoteTap,
  });

  final bool removeShare;
  final int? comments;
  final int? votes;
  final Function(String)? onVoteTap;

  @override
  State<ReactBar> createState() => _ReactBarState();
}

class _ReactBarState extends State<ReactBar> {
  int react = 0;

  @override
  void initState() {
    react = widget.votes ?? 0;
    super.initState();
  }

  void _onItemTapped(int vote) {
    setState(() {
      react = vote;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          CustomImageView(
            onTap: () {
              _onItemTapped((react == 1) ? 0 : 1);
              widget.onVoteTap?.call((react > 0) ? 'upvote' : 'downvote');
            },
            imagePath: AssetsApp.arrowUpIcon,
            color: react == 1 ? ColorsManager.mainColorDark : null,
            width: 16.w,
            height: 16.h,
          ),
          4.widthBox,
          Text(react.toString(), style: Styles.font14w500),
          4.widthBox,
          CustomImageView(
            onTap: () {
              _onItemTapped((react == -1) ? 0 : -1);
              widget.onVoteTap?.call((react < 0) ? 'downvote' : 'upvote');
            },
            imagePath: AssetsApp.arrowDownIcon,
            color: react == -1 ? ColorsManager.orangeColor : null,
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
          Text(widget.comments?.toString() ?? '0', style: Styles.font14w500),
          Spacer(),
          if (!widget.removeShare)
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
  }
}
