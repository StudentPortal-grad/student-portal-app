import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/user_row_view.dart';

class FollowersScreen extends StatefulWidget {
  const FollowersScreen({super.key, this.followers = const []});

  final List<UserSibling> followers;

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  final TextEditingController _controller = TextEditingController();
  List<UserSibling> _filteredFollowers = [];

  @override
  void initState() {
    super.initState();
    _filteredFollowers = widget.followers;
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredFollowers = widget.followers.where((user) {
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
            ),
            Expanded(
              child: _filteredFollowers.isEmpty
                  ? Center(child: "No results found".make())
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
                itemBuilder: (context, index) => UserRowView(user: _filteredFollowers[index].toUser()),
                separatorBuilder: (context, index) => 15.heightBox,
                itemCount: _filteredFollowers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
