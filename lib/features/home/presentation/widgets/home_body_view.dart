import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/home/presentation/widgets/post_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../core/widgets/loading_screen.dart';
import '../../../../core/widgets/no_data_view.dart';
import '../../data/dto/vote_dto.dart';
import '../../data/model/post_model/post.dart';
import '../manager/discussion_bloc/discussion_bloc.dart';

class HomeBodyView extends StatefulWidget {
  const HomeBodyView({super.key, this.discussions = const []});

  final List<Discussion> discussions;

  @override
  State<HomeBodyView> createState() => _HomeBodyViewState();
}

class _HomeBodyViewState extends State<HomeBodyView> {
  late final ScrollController _scrollController;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 300 &&
        !_isLoadingMore) {
      final bloc = context.read<DiscussionBloc>();
      final state = bloc.state;
      if (state is DiscussionLoaded && state.hasMore) {
        _isLoadingMore = true;
        bloc.add(DiscussionLoadMoreRequested());
      }
    }
  }

  @override
  void didUpdateWidget(covariant HomeBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoadingMore = false; // reset on every update
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: () async {
        _isLoadingMore = false;
        context.read<DiscussionBloc>().add(DiscussionRequested());
      },
      child: SafeArea(
        child: BlocBuilder<DiscussionBloc, DiscussionState>(
          builder: (context, state) {
            final discussions = (state is DiscussionLoaded) ? state.posts : widget.discussions;
            if (discussions.isEmpty) {
              return NoDataView(text: 'No Discussions');
            }
            return ListView.separated(
              shrinkWrap: true,
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
              separatorBuilder: (context, index) => 15.heightBox,
              itemBuilder: (context, index) {
                if (index < discussions.length) {
                  return PostView(
                    onSelect: (p0) {
                      if(p0 == 'delete'){
                        context.read<DiscussionBloc>().add(DeleteDiscussionEvent(discussions[index].id ?? ''),);
                      }
                    },
                    navToDetails: true,
                    onVoteTap: (p0) {
                      context.read<DiscussionBloc>().add(
                            VoteDiscussionEvent(
                                voteDto: VoteDto(
                                    postId: discussions[index].id ?? '',
                                    voteType: p0)),
                          );
                    },
                    discussion: discussions[index],
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: LoadingScreen(
                        highlightColor: ColorsManager.mainColor,
                        baseColor: ColorsManager.mainColorLight,
                      ),
                    ),
                  );
                }
              },
              itemCount: (state is DiscussionLoaded && state.hasMore)
                  ? discussions.length + 1
                  : discussions.length,
            );
          },
        ),
      ),
    );
  }
}
