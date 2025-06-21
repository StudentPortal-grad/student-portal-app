import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/features/home/domain/entities/post_entity.dart';

import '../../../../core/utils/app_router.dart';
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
      itemBuilder: (context, index) => GestureDetector(
        onTap: () => AppRouter.router.push(AppRouter.postDetails,extra: {'post' : posts[index]}),
        child: PostView(
          onVoteTap: (p0) => AppRouter.router.push(AppRouter.postDetails,extra: {'post' : posts[index]}),
          discussion: posts[index],
          navToDetails: true,
        ),
      ),
      itemCount: posts.length,
    );
  }
}
