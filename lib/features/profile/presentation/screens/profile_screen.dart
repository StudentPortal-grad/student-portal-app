import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/repo/user_repository.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import '../../../../core/theming/text_styles.dart';
import '../manager/profile_bloc/profile_bloc.dart';
import '../widgets/about_profile_user_view.dart';
import '../widgets/profile_card_veiw.dart';
import '../widgets/profile_posts_view.dart';
import '../widgets/profile_resources_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, this.userId});

  final String? userId;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final ScrollController _scrollController;
  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();

    _profileBloc = context.read<ProfileBloc>();
    final userId = widget.userId ?? UserRepository.user?.id;
    _profileBloc.add(
      userId == null || userId == UserRepository.user?.id
          ? GetMyProfileEvent(refresh: false)
          : GetUserProfileEvent(userId: userId),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    _profileBloc.close();
    super.dispose();
  }

  Future<void> _onPostTap() async {
    _tabController.animateTo(1,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    await Future.delayed(const Duration(milliseconds: 300));
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.backgroundColorDeep,
      body: BlocProvider.value(
        value: _profileBloc,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return LoadingScreen();
            }
            if(state is ProfileFailureState) {
              return ErrorScreen(
                showArrowBack: true,
                onRetry: () {
                  _profileBloc.add(
                      widget.userId == null || widget.userId == UserRepository.user?.id
                          ? GetMyProfileEvent(refresh: false)
                          : GetUserProfileEvent(userId: widget.userId ?? ''));
                },
              );
            }

            if (state is ProfileSuccessState) {
              return CustomRefreshIndicator(
                onRefresh: () async {
                  _profileBloc.add(
                      widget.userId == null || widget.userId == UserRepository.user?.id
                          ? GetMyProfileEvent(refresh: false)
                          : GetUserProfileEvent(userId: widget.userId ?? ''));
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  controller: _scrollController,
                  child: Column(
                    children: [
                      ProfileCardView(onPostsTap: _onPostTap, user: state.user),
                      TabBar(
                        controller: _tabController,
                        splashFactory: NoSplash.splashFactory,
                        dividerColor: Colors.transparent,
                        labelStyle: Styles.font14w400,
                        indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              color: ColorsManager.mainColor, width: 2.5.w),
                          borderRadius: BorderRadius.circular(7.r),
                        ),
                        labelColor: ColorsManager.mainColor,
                        tabs: const [
                          Tab(text: 'ABOUT'),
                          Tab(text: 'POST'),
                          Tab(text: 'RESOURCES'),
                        ],
                      ),
                      SizedBox(
                        height: 0.75.sh,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            AboutProfileUserView(userProfile: state.user.profile),
                            const ProfilePostsView(),
                            const ProfileResourcesView(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
