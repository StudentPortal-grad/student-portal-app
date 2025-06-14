import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/widgets/custom_refresh_indicator.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';

import '../../../../core/theming/colors.dart';
import '../../../../core/theming/text_styles.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/utils/debouncer.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../search/presentation/screens/not_found_search_view.dart';
import '../../../search/presentation/widgets/searched_people.dart';
import '../manager/search_people_bloc/search_people_bloc.dart';

class SearchPeerScreen extends StatefulWidget {
  const SearchPeerScreen({super.key});

  @override
  State<SearchPeerScreen> createState() => _SearchPeerScreenState();
}

class _SearchPeerScreenState extends State<SearchPeerScreen> {
  late final TextEditingController _controller;
  late final Debouncer _debouncer;
  late final SearchPeopleBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchPeopleBloc>();
    _controller = TextEditingController();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _controller.dispose();
    _debouncer.dispose();
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
              onChanged: (value) {
                _debouncer.run(() {
                  log('Searching $value');
                  bloc.add(
                    SearchPeopleEventStarted(
                      query: value.isNotEmpty ? value : null,
                      noLoading: true,
                    ),
                  );
                });
              },
              hintText: 'Search...',
            ),
            20.heightBox,
            Expanded(
              child: BlocBuilder<SearchPeopleBloc, SearchPeopleState>(
                builder: (context, state) {
                  if (state is SearchPeopleLoading) {
                    return LoadingScreen();
                  }
                  if (state is SearchPeopleFailed) {
                    return ErrorScreen(
                      onRetry: () => bloc.add(SearchPeopleEventStarted()),
                    );
                  }
                  if (state is SearchPeopleLoaded) {
                    final child = state.userSiblings.isEmpty
                        ? NotFoundView()
                        : SearchedPeople(users: state.userSiblings);
                    return CustomRefreshIndicator(
                      onRefresh: () async => bloc.add(SearchPeopleEventStarted(query: _controller.text)),
                      child: child,
                    );
                  }
                  return NotFoundView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
