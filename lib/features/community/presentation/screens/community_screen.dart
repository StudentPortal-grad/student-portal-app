import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../profile/presentation/widgets/about_profile_user_view.dart';
import '../../../profile/presentation/widgets/profile_posts_view.dart';
import '../../../profile/presentation/widgets/profile_resources_view.dart';
import '../widgets/community_card_view.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _onPostTap() async {
    _tabController.animateTo(1, duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    await Future.delayed(Duration(milliseconds: 400));
    _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: Duration(milliseconds: 400), curve: Curves.fastOutSlowIn);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorDeep,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            CommunityCardView(onPostsTap: _onPostTap),
            TabBar(
              splashFactory: NoSplash.splashFactory,
              dividerColor: Colors.transparent,
              labelStyle: Styles.font14w400,
              indicator: UnderlineTabIndicator(
                borderSide:
                BorderSide(color: ColorsManager.mainColor, width: 2.5.w),
                borderRadius: BorderRadius.circular(7.r),
              ),
              labelColor: ColorsManager.mainColor,
              tabs: [
                Tab(text: 'ABOUT'),
                Tab(text: 'POST'),
                Tab(text: 'RESOURCES'),
              ],
              controller: _tabController,
            ),
            SizedBox(
              height: 0.75.sh,
              child: TabBarView(
                controller: _tabController,
                children: [
                  AboutProfileUserView(),
                  ProfilePostsView(),
                  ProfileResourcesView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
