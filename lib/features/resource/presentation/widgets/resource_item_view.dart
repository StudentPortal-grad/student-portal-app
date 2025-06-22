import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/time_formatting_helper.dart';
import 'package:student_portal/features/resource/presentation/manager/resource_react_bar_bloc/resource_react_bar_bloc.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_react_bar.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/theming/text_styles.dart';
import '../../../../../core/widgets/app_text.dart';
import '../../../../core/utils/app_router.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';
import '../manager/get_resource_bloc/get_resource_bloc.dart';
import 'pdf_post_view.dart';
import '../../../home/presentation/widgets/user_post_view.dart';
import '../../data/model/resource.dart';

class ResourceItemView extends StatefulWidget {
  const ResourceItemView({
    super.key,
    this.detailsChildren,
    this.resource,
    this.onVoteTap,
    this.navToDetails = false,
    this.onSelect,
  });

  final Resource? resource;
  final List<Widget>? detailsChildren;
  final Function(String)? onVoteTap;
  final bool navToDetails;
  final Function(String?)? onSelect;

  @override
  State<ResourceItemView> createState() => _ResourceItemViewState();
}

class _ResourceItemViewState extends State<ResourceItemView> {
  late final ResourceReactBarBloc _reactBarBloc;

  @override
  void initState() {
    super.initState();
    _reactBarBloc = ResourceReactBarBloc()
      ..add(
        InitializeResourceVotes(
          upVotes: widget.resource?.upVotesCount ?? 0,
          downVotes: widget.resource?.downVotesCount ?? 0,
          currentVote: widget.resource?.currentVote ?? 0,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _reactBarBloc,
      child: GestureDetector(
        onTap: () async {
          if (widget.navToDetails) {
            final updatedPost = await AppRouter.router.push<Resource>(
                AppRouter.resourceDetails,
                extra: {'resource': widget.resource});
            if (updatedPost != null) {
              log('updatedPost: ${updatedPost.toJson()}');
              final bloc = context.mounted
                  ? context.read<GetResourceBloc>()
                  : AppRouter.context?.read<GetResourceBloc>();
              if (bloc != null) {
                bloc.add(UpdateResourceInListEvent(updatedPost));
              }
              _reactBarBloc.add(InitializeResourceVotes(
                  upVotes: updatedPost.upVotesCount ?? 0,
                  downVotes: updatedPost.downVotesCount ?? 0,
                  currentVote: updatedPost.currentVote ?? 0));
            } else {
              final bloc = context.read<GetResourceBloc>();
              bloc.add(GetResourceEventRequested(noLoading: false));
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 7,
                blurStyle: BlurStyle.outer,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10.r),
            ),
          ),
          padding: EdgeInsets.all(18.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserPostView(
                onSelect: widget.onSelect,
                uploader: widget.resource?.uploader,
                createFromAgo: TimeHelper.instance.timeAgo(widget.resource?.createdAt),
              ),
              if (widget.resource?.tags?.isNotEmpty ?? false) ...[
                21.heightBox,
                Wrap(
                  spacing: 7.w,
                  runSpacing: 7.h,
                  children: List.generate(
                    widget.resource?.tags?.length ?? 0,
                    (index) => CategoryTagView(
                      index: index,
                      title: widget.resource?.tags?[index] ?? '',
                    ),
                  ),
                ),
                20.heightBox,
              ],
              Text(widget.resource?.title ?? '', style: Styles.font14w700),
              10.heightBox,
              AppText(
                onHashTagTap: (p0) {
                  debugPrint('HASH TAG');
                  debugPrint(p0);
                },
                onMentionTap: (p0) {
                  debugPrint('on Mention');
                  debugPrint(p0);
                },
                text: widget.resource?.description ?? '',
                style: Styles.font12w400.copyWith(color: ColorsManager.grayColor, height: 1.9),
              ),
              20.heightBox,
              if (widget.resource?.fileUrl != null)
                ListView.separated(
                  itemBuilder: (context, index) => PdfPostView(
                    title: widget.resource?.originalFileName ?? widget.resource?.fileUrl?.split('/').last ??'',
                    url: widget.resource?.fileUrl ?? '',
                    size: widget.resource?.fileSize,
                  ),
                  separatorBuilder: (context, index) => 10.heightBox,
                  shrinkWrap: true,
                  itemCount: 1,
                  physics: NeverScrollableScrollPhysics(),
                ),
              17.heightBox,
              // react bar
              ResourceReactBar(
                comments: widget.resource?.comments?.length ?? 0,
                onVoteTap: (p0) {
                  log('onVoteTap $p0');
                  widget.onVoteTap?.call(p0);
                },
              ),
              if (widget.detailsChildren != null) ...[
                17.heightBox,
                ...widget.detailsChildren!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
