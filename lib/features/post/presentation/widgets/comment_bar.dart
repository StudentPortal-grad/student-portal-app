import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/contestants.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';

class CommentBar extends StatefulWidget {
  const CommentBar({super.key, this.initComment});

  final String? initComment;

  @override
  State<CommentBar> createState() => _CommentBarState();
}

class _CommentBarState extends State<CommentBar> {
  late final TextEditingController commentController;
  bool isEmpty = true;

  @override
  void initState() {
    commentController = TextEditingController(text: widget.initComment ?? '');
    commentController.addListener(() {
      setState(() {
        isEmpty = commentController.text.isEmpty;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    commentController.removeListener(() {});
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomImageView(
          imagePath: kUserImage,
          circle: true,
          height: 38.r,
          width: 38.r,
        ),
        8.widthBox,
        Expanded(
          child: CustomTextField(
            height: 38.h,
            controller: commentController,
            suffix: isEmpty
                ? null
                : InkWell(
                    onTap: () {
                      debugPrint(commentController.text);
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: ColorsManager.mainColor,
                      size: 20.sp,
                    ),
                  ),
            hintText: 'Comment',
            expanded: true,
            textInputType: TextInputType.multiline,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
          ),
        ),
      ],
    );
  }
}
