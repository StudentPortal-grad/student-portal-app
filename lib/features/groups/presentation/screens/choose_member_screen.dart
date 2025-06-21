import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/data/model/error_model.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/assets_app.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_image_view.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/groups/presentation/manager/create_group_bloc/create_group_bloc.dart';
import 'package:student_portal/features/groups/presentation/widgets/member_item_view.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../home/presentation/widgets/category_tag_view.dart';

class ChooseMemberScreen extends StatefulWidget {
  const ChooseMemberScreen({super.key, this.title, required this.bloc});

  final String? title;
  final CreateGroupBloc bloc;

  @override
  State<ChooseMemberScreen> createState() => _ChooseMemberScreenState();
}

class _ChooseMemberScreenState extends State<ChooseMemberScreen> {
  late final TextEditingController _searchController;
  late final Debouncer _debouncer;

  @override
  void initState() {
    _searchController = TextEditingController();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: Text(widget.title ?? 'New Group', style: Styles.font20w600),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.heightBox,
              BlocBuilder<CreateGroupBloc, CreateGroupState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 30.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CategoryTagView(
                        index: index,
                        title: widget.bloc.selectedUsers.toList()[index].name ?? '',
                        removeTap: (p0) => widget.bloc.add(AddOrRemoveUsers(widget.bloc.selectedUsers.toList()[index],isAdding: false)),
                        backGround: ColorsManager.babyBlue,
                        textColor: ColorsManager.mainColor,
                        borderColor: ColorsManager.mainColorLight,
                      ),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => 10.widthBox,
                      itemCount: widget.bloc.selectedUsers.length,
                    ),
                  );
                },
              ),
              20.heightBox,
              CustomTextField(
                controller: _searchController,
                onChanged: (value) {
                  _debouncer.run(() {
                    log('Searching $value');
                    widget.bloc.add(
                      GetUsersSiblings(
                        query: value.isNotEmpty ? value : null,
                        noLoading: true,
                      ),
                    );
                  });
                },
                prefixIcon: CustomImageView(imagePath: AssetsApp.search2Icon, fit: BoxFit.none),
                hintText: 'Search',
              ),
              20.heightBox,
              Expanded(
                child: BlocBuilder<CreateGroupBloc, CreateGroupState>(
                  buildWhen: (previous, current) => (current is GetSiblingsUserLoaded ||
                        current is GetSiblingsUserFailed ||
                        current is GetSiblingsUserLoading),
                  builder: (context, state) {
                    if (state is GetSiblingsUserLoading) {
                      return LoadingScreen(useMainColors: true);
                    }
                    if (state is GetSiblingsUserFailed) {
                      return ErrorScreen(
                        failure: Failure(message: state.message),
                        onRetry: () => context.read<CreateGroupBloc>().add(GetUsersSiblings()),
                      );
                    }
                    if (state is GetSiblingsUserLoaded) {
                      return CustomRefreshIndicator(
                        onRefresh: () async => context.read<CreateGroupBloc>().add(GetUsersSiblings()),
                        child: ListView.separated(
                          itemCount: state.siblingsUser.length,
                          separatorBuilder: (context, index) => 15.heightBox,
                          itemBuilder: (context, index) => MemberItemView(
                            onTap: () => widget.bloc.add(AddOrRemoveUsers(state.siblingsUser[index],isAdding: true)),
                            userSibling: state.siblingsUser[index],
                            showRemoveIcon: false,
                            showIsMemberSelected: false,
                          ),
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
