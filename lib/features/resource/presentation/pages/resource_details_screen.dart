import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../home/presentation/widgets/comment_bar.dart';
import '../../../home/presentation/widgets/post_comments_view.dart';
import '../../../home/presentation/widgets/post_view.dart';



class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
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
        centerTitle: false,
        title: Text('Resource', style: Styles.font20w600),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: PostView(
          detailsChildren: [
            CommentBar(),
            20.heightBox,
            ...List.generate(2, (index) => PostCommentsView()),
          ],
        ),
      ),
    );
  }
}
