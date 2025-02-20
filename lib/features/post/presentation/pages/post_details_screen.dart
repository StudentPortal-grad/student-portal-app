import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/features/home/presentation/widgets/post_view.dart';

import '../../../../core/widgets/custom_appbar.dart';
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
      children: [],
    );
  }
}
