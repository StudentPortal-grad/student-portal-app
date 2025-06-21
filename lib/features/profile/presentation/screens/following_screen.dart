import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/user_row_view.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key, this.userId, this.following = const []});

  final String? userId;
  final List<UserSibling> following;

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  final TextEditingController _controller = TextEditingController();
  List<UserSibling> _filteredFollowing = [];

  @override
  void initState() {
    super.initState();
    _filteredFollowing = widget.following;
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredFollowing = widget.following.where((user) {
        final userData = user.toUser();
        return userData.name?.toLowerCase().contains(query) ?? false;
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorDeep,
      appBar: CustomAppBar(
        backgroundColor: Colors.transparent,
        title: "Following".make(style: Styles.font20w600),
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
            ),
            25.heightBox,
            Expanded(
              child: _filteredFollowing.isEmpty
                  ? Center(child: "No results found".make())
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                      itemBuilder: (context, index) => UserRowView(
                        // showRemoveIcon: widget.userId == UserRepository.user?.id,
                        user: (_filteredFollowing[index]).toUser(),
                      ),
                      separatorBuilder: (context, index) => 15.heightBox,
                      itemCount: _filteredFollowing.length,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
