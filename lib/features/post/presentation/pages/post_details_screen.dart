import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/text_parser.dart';
import 'package:student_portal/features/home/presentation/widgets/post_view.dart';
import 'package:student_portal/features/home/presentation/widgets/react_bar.dart';

import '../../../../core/widgets/custom_appbar.dart';
import '../../../home/presentation/widgets/user_post_view.dart';
import '../widgets/comment_bar.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsManager.backgroundColor,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.whiteColor,
        title: Text('Post Details', style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: PostView(
          id: 0,
          detailsChildren: [
            CommentBar(),
            20.heightBox,
            PostCommentsView(),
          ],
        ),
      ),
    );
  }
}

class PostCommentsView extends StatelessWidget {
  const PostCommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        buildCommentView(showDivider: true),
        buildCommentView(),
      ],
    );
  }

  Widget buildCommentView({bool showDivider = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        UserPostView(),
        10.heightBox,
        IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Spacer(),
              if (showDivider) ...[
                Container(
                  width: 1,
                  // height: double.infinity, // This makes it expand to available height
                  color: ColorsManager.lightGreyColor,
                ),
                Spacer(),
              ],
              SizedBox(
                width: 250.w,
                child: Column(
                  children: [
                    TextParser(
                      text:
                          'These methods include quantitative techniques, such as statistical analysis and machine learning algorithms.',
                    ),
                    10.heightBox,
                    ReactBar(removeShare: true),
                    10.heightBox,
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
