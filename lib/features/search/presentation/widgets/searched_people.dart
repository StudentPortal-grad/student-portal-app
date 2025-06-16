import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/groups/data/models/user_sibling.dart';
import 'package:student_portal/features/search/presentation/widgets/user_searched_view.dart';

import '../screens/not_found_search_view.dart';

class SearchedPeople extends StatelessWidget {
  const SearchedPeople({super.key, this.users = const [], this.showNotFound = false});

  final List<UserSibling> users;
  final bool showNotFound;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty && showNotFound) return const NotFoundView();

    return ListView.separated(
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
      itemBuilder: (context, index) => UserSearchedView(user: users[index],showDmButton: true),
      separatorBuilder: (context, index) => 15.heightBox,
      itemCount: users.length,
    );
  }
}
