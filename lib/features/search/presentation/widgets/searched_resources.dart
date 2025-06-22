import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';

import '../../../home/data/dto/vote_dto.dart';
import '../../../resource/data/model/resource.dart';
import '../../../resource/presentation/manager/get_resource_bloc/get_resource_bloc.dart';
import '../../../resource/presentation/widgets/resource_item_view.dart';
import '../screens/not_found_search_view.dart';

class SearchedResources extends StatelessWidget {
  const SearchedResources({super.key, this.resources = const []});

  final List<Resource> resources;

  @override
  Widget build(BuildContext context) {
    if (resources.isEmpty) return const NotFoundView();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => ResourceItemView(
        onSelect: (p0) {
          if (p0 == 'delete') {
            context.read<GetResourceBloc>().add(DeleteResourceEvent(resourceId: resources[index].id ?? ''));
          }
        },
        navToDetails: true,
        onVoteTap: (p0) {
          context.read<GetResourceBloc>().add(
            VoteResourceEvent(
              voteDto: VoteDto(
                  postId: resources[index].id ?? '',
                  voteType: p0),
            ),
          );
        },
        resource: resources[index],
      ),
      itemCount: resources.length,
    );
  }
}
