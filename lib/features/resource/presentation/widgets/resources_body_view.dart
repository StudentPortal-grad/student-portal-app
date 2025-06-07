import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/features/resource/presentation/widgets/resource_item_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/widgets/custom_refresh_indicator.dart';
import '../../../../core/widgets/loading_screen.dart';
import '../../data/model/resource.dart';
import '../manager/get_resource_bloc/get_resource_bloc.dart';

class ResourcesBodyView extends StatefulWidget {
  const ResourcesBodyView({super.key, this.resources = const []});

  final List<Resource> resources;

  @override
  State<ResourcesBodyView> createState() => _ResourcesBodyViewState();
}

class _ResourcesBodyViewState extends State<ResourcesBodyView> {
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
      final bloc = context.read<GetResourceBloc>();
      final state = bloc.state;
      if (state is GetResourceLoaded && state.hasMore) {
        _isLoadingMore = true;
        bloc.add(GetResourceEventLoadMore());
      }
    }
  }

  @override
  void didUpdateWidget(covariant ResourcesBodyView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isLoadingMore = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomRefreshIndicator(
        onRefresh: () async {
          _isLoadingMore = false;
          context.read<GetResourceBloc>().add(GetResourceEventRequested());
        },
        child: BlocBuilder<GetResourceBloc, GetResourceState>(
          builder: (context, state) {
            final resources = (state is GetResourceLoaded)
                ? state.resources
                : widget.resources;

            return ListView.separated(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 15.h),
              separatorBuilder: (context, index) => 15.heightBox,
              itemCount: (state is GetResourceLoaded && state.hasMore)
                  ? resources.length + 1
                  : resources.length,
              itemBuilder: (context, index) {
                if (index < resources.length) {
                  return InkWell(
                    child: ResourceItemView(resource: resources[index]),
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
            );
          },
        ),
      ),
    );
  }
}
