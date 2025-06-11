import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_details_bloc/resource_details_bloc.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_item_view.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/errors/view/error_screen.dart';
import '../../../../core/utils/app_router.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../home/data/dto/vote_dto.dart';
import '../../../home/data/model/post_model/reply.dart';
import '../../../home/presentation/widgets/discussion_shimmer.dart';
import '../../../home/presentation/widgets/post_comments_view.dart';
import '../../data/model/resource.dart';
import '../widgets/resource_comment_bar.dart';

class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({super.key});

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen> {
  late final ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          final Resource resource = context.read<ResourceDetailsBloc>().resource;
          AppRouter.router.pop(resource);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: ColorsManager.backgroundColor,
        appBar: CustomAppBar(
          leadingOnTap: () {
            final Resource resource = context.read<ResourceDetailsBloc>().resource;
            AppRouter.router.pop(resource);
          },
          backgroundColor: ColorsManager.whiteColor,
          centerTitle: false,
          title: Text('Resource', style: Styles.font20w600),
        ),
        body: BlocConsumer<ResourceDetailsBloc, ResourceDetailsState>(
          listener: (context, state) {
            if (state is AddCommentSuccessState) {
              context.read<ResourceDetailsBloc>().add(GetResourceEvent(resourceId:  context.read<ResourceDetailsBloc>().resource.id ?? '', noLoading: true));
            }
          },
          builder: (context, state) {
            final bloc = context.read<ResourceDetailsBloc>();
            if (state is ResourceDetailsLoadingState) {
              return DiscussionShimmer();
            }
            if (state is ResourceDetailsErrorState) {
              return ErrorScreen(
                  showArrowBack: true,
                  onRetry: () => bloc.add(GetResourceEvent(resourceId: bloc.resource.id ?? '')),
                  failure: Failure(message: state.message));
            }
            return CustomRefreshIndicator(
              onRefresh: () async => bloc.add(GetResourceEvent(resourceId: bloc.resource.id ?? '')),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: ResourceItemView(
                  resource: bloc.resource,
                  onVoteTap: (p0) {
                    bloc.add(VoteDiscussionEventRequest(
                      voteDto: VoteDto(postId: bloc.resource.id ?? '', voteType: p0)));
                  },
                  detailsChildren: [
                    ResourceCommentBar(),
                    20.heightBox,
                    ..._buildCommentsView(replies: bloc.resource.comments ?? []),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  List<Widget> _buildCommentsView(
      {bool isLoading = false, List<Reply> replies = const []}) {
    if (isLoading) {
      return List.generate(
          3, (index) => PostCommentsView.buildShimmerComment());
    }
    return List.generate(
        replies.length, (index) => PostCommentsView(reply: replies[index]));
  }
}
