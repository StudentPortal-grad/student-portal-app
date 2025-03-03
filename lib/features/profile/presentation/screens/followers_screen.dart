import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/user_row_view.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorDeep,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Followers".make(style: Styles.font20w600),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            15.heightBox,
            CustomTextField(
              controller: _controller,
              prefixIcon: CustomImageView(
                imagePath: AssetsApp.search2Icon,
                fit: BoxFit.none,
              ),
              hintText: 'Search...',
              onFieldSubmitted: (p0) {},
            ),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                itemBuilder: (context, index) => UserRowView(),
                separatorBuilder: (context, index) => 15.heightBox,
                itemCount: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
