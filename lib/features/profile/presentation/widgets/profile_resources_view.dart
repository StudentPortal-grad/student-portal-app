import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/helpers/app_text_view.dart';
import 'package:student_portal/features/resource/domain/entities/resource_entity.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_item_view.dart';

import '../../../home/data/dto/vote_dto.dart';
import '../../../resource/presentation/manager/get_resource_bloc/get_resource_bloc.dart';

class ProfileResourcesView extends StatelessWidget {
  const ProfileResourcesView({super.key, this.resources = const []});

  final List<ResourceEntity> resources;

  @override
  Widget build(BuildContext context) {
    if(resources.isEmpty) {
      return Padding(padding: EdgeInsets.symmetric(vertical: 0.25.sh),child: "There's no resources".make());
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
      separatorBuilder: (context, index) => 15.heightBox,
      itemBuilder: (context, index) => ResourceItemView(
        onVoteTap: (p0) => context.read<GetResourceBloc>().add(VoteResourceEvent(voteDto: VoteDto(postId: resources[index].id ?? '', voteType: p0))),
        navToDetails: true,
        onSelect: (p0) {
          if (p0 == 'delete') {
            context.read<GetResourceBloc>().add(DeleteResourceEvent(resourceId: resources[index].id ?? ''));
          }
        },
        resource: resources[index],
      ),
      itemCount: resources.length,
    );
  }
}
