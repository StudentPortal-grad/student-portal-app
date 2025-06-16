import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/features/search/data/model/global_search.dart';
import 'package:student_portal/features/search/presentation/widgets/searched_events.dart';
import 'package:student_portal/features/search/presentation/widgets/searched_people.dart';
import 'package:student_portal/features/search/presentation/widgets/searched_posts.dart';
import 'package:student_portal/features/search/presentation/widgets/searched_resources.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';

class SearchBodyView extends StatelessWidget {
  const SearchBodyView({super.key, required this.tabController, this.globalSearch});
  final GlobalSearch? globalSearch;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          splashFactory: NoSplash.splashFactory,
          isScrollable: true,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          labelStyle: Styles.font16w500,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: ColorsManager.mainColor, width: 3.w),
              borderRadius: BorderRadius.circular(7.r)),
          labelColor: ColorsManager.mainColor,
          tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Resources'),
            Tab(text: 'Events'),
            // Tab(text: 'Communities'),
            Tab(text: 'People'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              SearchedPosts(discussions: globalSearch?.discussions ?? [],),
              SearchedResources(resources: globalSearch?.resources ?? [],),
              SearchedEvents(events: globalSearch?.events ?? [],),
              // SearchedCommunities(),
              SearchedPeople(users: globalSearch?.users ?? [], showNotFound: true),
            ],
          ),
        ),
      ],
    );
  }
}