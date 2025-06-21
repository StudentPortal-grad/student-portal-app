import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:student_portal/core/errors/view/error_screen.dart';
import 'package:student_portal/core/helpers/app_size_boxes.dart';
import 'package:student_portal/core/theming/colors.dart';
import 'package:student_portal/core/theming/text_styles.dart';
import 'package:student_portal/core/utils/debouncer.dart';
import 'package:student_portal/core/widgets/custom_appbar.dart';
import 'package:student_portal/core/widgets/custom_text_field.dart';
import 'package:student_portal/core/widgets/loading_screen.dart';
import 'package:student_portal/features/search/presentation/manager/global_search_bloc/global_search_bloc.dart';

import '../../../../core/errors/data/model/error_model.dart';
import '../../../../core/utils/assets_app.dart';
import '../../../../core/widgets/custom_image_view.dart';
import '../widgets/search_body_view.dart';
import 'not_found_search_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, this.searchText});

  final String? searchText;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late final TextEditingController _controller;
  late final TabController _tabController;
  late final Debouncer _debouncer;
  late final GlobalSearchBloc bloc;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _controller = TextEditingController(text: widget.searchText);
     bloc = context.read<GlobalSearchBloc>();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorsManager.backgroundColorLight,
      appBar: CustomAppBar(
        backgroundColor: ColorsManager.backgroundColorLight,
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
              hintText: 'Search...',
              onChanged: (value) {
                _debouncer.run(() {
                  log('Searching $value');
                  bloc.add(
                    SearchEventRequest(
                      query: value.isNotEmpty ? value : null,
                      noLoading: true,
                    ),
                  );
                });
              },
              onFieldSubmitted: (value) {
                bloc.add(
                  SearchEventRequest(
                    query: value.isNotEmpty ? value : null,
                    noLoading: true,
                  ),
                );
              },
            ),
            20.heightBox,
            Expanded(
              child: BlocBuilder<GlobalSearchBloc,GlobalSearchState>(
                builder: (context, state) {
                  if(state is GlobalSearchLoading){
                    return LoadingScreen(useMainColors: true);
                  }
                  if (state is GlobalSearchFailed) {
                    return ErrorScreen(failure: Failure(message: state.message));
                  }
                  if(state is GlobalSearchLoaded) {
                    if ((state.globalSearch.discussions?.isEmpty ?? false) &&
                        (state.globalSearch.events?.isEmpty ?? false) &&
                        (state.globalSearch.resources?.isEmpty ?? false) &&
                        (state.globalSearch.users?.isEmpty ?? false)) {
                      return const NotFoundView();
                    }
                    return SearchBodyView(tabController: _tabController,globalSearch: state.globalSearch,);
                  }
                  return const NotFoundView();
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}

