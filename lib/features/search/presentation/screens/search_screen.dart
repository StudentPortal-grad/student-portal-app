import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';

import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../widgets/searched_communities.dart';
import '../widgets/searched_events.dart';
import '../widgets/searched_people.dart';
import '../widgets/searched_posts.dart';
import '../widgets/searched_resources.dart';
import 'not_found_search_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.searchText});

  final String? searchText;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late final TextEditingController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _controller = TextEditingController(text: widget.searchText);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColor,
        title: Text(
          'Search',
          style: Styles.font20w600,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 24.w),
        child: Column(
          children: [
            CustomTextField(
              controller: _controller,
              prefixIcon: CustomImageView(
                imagePath: AssetsApp.search2Icon,
                fit: BoxFit.none,
              ),
              hintText: 'Search...',
              onFieldSubmitted: (p0) {},
            ),
            20.heightBox,
            // Expanded(child: NotFoundView()),
            Expanded(child: SearchBodyView(tabController: _tabController)),
          ],
        ),
      ),
    );
  }
}
class SearchBodyView extends StatelessWidget {
  const SearchBodyView({super.key, required this.tabController});

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
              borderSide:
                  BorderSide(color: ColorsManager.mainColor, width: 3.w),
              borderRadius: BorderRadius.circular(7.r)),
          labelColor: ColorsManager.mainColor,
          tabs: [
            Tab(text: 'Posts'),
            Tab(text: 'Resources'),
            Tab(text: 'Events'),
            Tab(text: 'Communities'),
            Tab(text: 'People'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              SearchedPosts(),
              SearchedResources(),
              SearchedEvents(),
              SearchedCommunities(),
              SearchedPeople(),
            ],
          ),
        ),
      ],
    );
  }
}
